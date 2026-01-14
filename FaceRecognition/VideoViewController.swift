import UIKit
import AVFoundation
import MobileCoreServices
import CoreData

class VideoViewController: UIViewController, UIAdaptivePresentationControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var faceView: FaceView!
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var enrolledImage: UIImageView!
    @IBOutlet weak var identifiedImage: UIImageView!
    @IBOutlet weak var identifiedLbl: UILabel!
    @IBOutlet weak var similarityLbl: UILabel!
    @IBOutlet weak var livenessLbl: UILabel!
    @IBOutlet weak var yawLbl: UILabel!
    @IBOutlet weak var rollLbl: UILabel!
    @IBOutlet weak var pitchLbl: UILabel!
// Assuming you have this

    // MARK: - Properties
     var player: AVPlayer?
     var playerLayer: AVPlayerLayer?
     var videoOutput: AVPlayerItemVideoOutput?
     var displayLink: CADisplayLink?
     var recognized = false
    
     var livenessThreshold: Float = 0.0
     var identifyThreshold: Float = 0.0
    
     var cameraLens_val = 0 // 0: back, 1: front
    

    // MARK: - CoreData setup
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: ViewController.CORE_DATA_NAME)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    @IBAction func done_clicked(_ sender: Any) {
        self.player?.pause()
        self.dismiss(animated: true)
        self.resultView.showView(isHidden_: false)
        recognized = false
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        let defaults = UserDefaults.standard
        cameraLens_val = defaults.integer(forKey: "camera_lens")
        livenessThreshold = defaults.float(forKey: "liveness_threshold")
        identifyThreshold = defaults.float(forKey: "identify_threshold")
        
        openGallery()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        player?.pause()
        dismiss(animated: true)
       
    }

    // MARK: - Gallery Picker
     func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.delegate = self
        picker.allowsEditing = false
         picker.presentationController?.delegate = self
        present(picker, animated: true)
    }

    // MARK: - Video Playback & Frame Extraction
     func startVideoProcessing(url: URL) {
        recognized = false
        
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        // AVPlayerItemVideoOutput to extract frames like camera
        let outputSettings: [String: Any] = [
            (kCVPixelBufferPixelFormatTypeKey as String): Int(kCVPixelFormatType_32BGRA)
        ]
        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: outputSettings)
        item.add(videoOutput!)
        
        player = AVPlayer(playerItem: item)
        playerLayer?.removeFromSuperlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoView.bounds
        playerLayer?.videoGravity = .resizeAspect
        videoView.layer.addSublayer(playerLayer!)
        videoView.isHidden = false
        player?.play()
        
        // Loop video
        
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player?.currentItem,
                queue: .main
            ) { [weak self] _ in
                self?.player?.seek(to: .zero)
                self?.player?.play()
        }
        // Poll frames using CADisplayLink
        displayLink = CADisplayLink(target: self, selector: #selector(pollVideoFrame))
        displayLink?.add(to: .main, forMode: .default)
    }

    @objc  func pollVideoFrame() {
        guard !recognized,
              let player = player,
              let output = videoOutput else { return }
        
          
        let playerTime = player.currentTime()
        if output.hasNewPixelBuffer(forItemTime: playerTime),
           let pixelBuffer = output.copyPixelBuffer(forItemTime: playerTime, itemTimeForDisplay: nil) {
            
            CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
                var uiImage = UIImage(cgImage: cgImage)
                
                // Rotate and flip like camera
                uiImage = uiImage.rotate(radians: .pi / 2)
                if cameraLens_val == 1 {
                    uiImage = uiImage.flipHorizontally()
                }
                
                // Detect faces
                detectFaces(in: uiImage)
            }
            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        }
    }

    // MARK: - Face Detection (full camera pipeline)
     func detectFaces(in capturedImage: UIImage) {
        if recognized { return }
        
        let faceBoxes = FaceSDK.faceDetection(capturedImage)
        
        DispatchQueue.main.async {
            self.faceView.setFrameSize(frameSize: capturedImage.size)
            self.faceView.setFaceBoxes(faceBoxes: faceBoxes)
        }
        
        guard faceBoxes.count > 0 else { return }
        
        let faceBox = faceBoxes[0] as! FaceBox
        
        if faceBox.liveness > livenessThreshold {
            let templates = FaceSDK.templateExtraction(capturedImage, faceBox: faceBox)
            
            var maxSimilarity: Float = 0
            var maxSimilarityName: String = ""
            var maxSimilarityFace: Data? = nil
            
            let context = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ViewController.ENTITIES_NAME)
            
            do {
                let persons = try context.fetch(fetchRequest) as! [NSManagedObject]
                for person in persons {
                    if let personTemplates = person.value(forKey: ViewController.ATTRIBUTE_TEMPLATES) as? Data {
                        let similarity = FaceSDK.similarityCalculation(templates, templates2: personTemplates)
                        if similarity > maxSimilarity {
                            maxSimilarity = similarity
                            maxSimilarityName = person.value(forKey: ViewController.ATTRIBUTE_NAME) as! String
                            maxSimilarityFace = person.value(forKey: ViewController.ATTRIBUTE_FACE) as? Data
                        }
                    }
                }
            } catch {
                print("Failed fetching: \(error)")
            }
            
            if maxSimilarity > identifyThreshold, let maxFaceData = maxSimilarityFace {
                let enrolledFaceImage = UIImage(data: maxFaceData)
                let identifiedFaceImage = capturedImage.cropFace(faceBox: faceBox)
          
                recognized = true
                
                DispatchQueue.main.async {
                    self.player?.pause()
                    self.videoView.isHidden = false
                    self.enrolledImage.image = enrolledFaceImage
                    self.identifiedImage.image = identifiedFaceImage
                    self.identifiedLbl.text = "Identified: " + maxSimilarityName
                    self.similarityLbl.text = "Similarity: " + String(format: "%.03f", maxSimilarity)
                    self.livenessLbl.text = "Liveness score: " + String(format: "%.03f", faceBox.liveness)
                    self.yawLbl.text = "Yaw: " + String(format: "%.03f", faceBox.yaw)
                    self.rollLbl.text = "Roll: " + String(format: "%.03f", faceBox.roll)
                    self.pitchLbl.text = "Pitch: " + String(format: "%.03f", faceBox.pitch)
                    self.resultView.showView(isHidden_: true)
                }
            }
        }
    }
    

    // MARK: - Cleanup
    deinit {
        displayLink?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension VideoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true){
            self.player?.pause()
            self.dismiss(animated: true)
        }
        activityIndicator.stopAnimating()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        picker.dismiss(animated: true)
        activityIndicator.stopAnimating()
        
        if let videoURL = info[.mediaURL] as? URL {
            startVideoProcessing(url: videoURL)
        } else {
            self.player?.pause()
            self.dismiss(animated: true)
        }
    }
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // Called when user swipes down
        activityIndicator.stopAnimating()
        dismiss(animated: true) // go back to previous screen
    }
    
}

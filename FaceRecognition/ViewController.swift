import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, PersonViewCellDelegate{
    
    static let CORE_DATA_NAME = "Model"
    static let ENTITIES_NAME = "Person"
    static let ATTRIBUTE_NAME = "name"
    static let ATTRIBUTE_FACE = "face"
    static let ATTRIBUTE_TEMPLATES = "templates"

    @IBOutlet weak var warningLbl: UILabel!
    
    @IBOutlet weak var enrollBtnView: UIView!
    @IBOutlet weak var identifyBtnView: UIView!
    @IBOutlet weak var settingsBtnView: UIView!
    @IBOutlet weak var aboutBtnView: UIView!
    
    @IBOutlet weak var personView: UITableView!
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: ViewController.CORE_DATA_NAME)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var ret = FaceSDK.setActivation("hazWdjsBTlcIs0hC9t+40JIKgQOTcag0lPNMdLxa8QkhAH1OllRuaNJ4pVolQ7rik+WVP6wlLbwT" +
                                        "eq/PpAAQpoKJo0ra6OeS8abfqaz+1VZ7kCtri+IkpuXDYAC6ozz75EGgDSjxg0V9gp2awmSn73H1" +
                                        "LMxWRC1bFn4VhSil2C9dz6KIXEwC3K9GRjsBnrKKJ5q32c/xA2458aBAyF1cD0VgXq7+nL2F2g1i" +
                                        "VEAGoED0l2PUjfLOECiM+CFp/iEJQfDgcKMqG+Ns744qBFjudcjb/hFl6KQh28A0AoF7j4pSlzbC" +
                                        "rtcltwQMJXPQ4pqTFCNFCr7ELueh3HUpmT9FOg==")
        
        if(ret == SDK_SUCCESS.rawValue) {
            ret = FaceSDK.initSDK()
        }
        
        if(ret != SDK_SUCCESS.rawValue) {
            warningLbl.isHidden = false
            
            if(ret == SDK_LICENSE_KEY_ERROR.rawValue) {
                warningLbl.text = "Invalid license!"
            } else if(ret == SDK_LICENSE_APPID_ERROR.rawValue) {
                warningLbl.text = "Invalid license!"
            } else if(ret == SDK_LICENSE_EXPIRED.rawValue) {
                warningLbl.text = "License expired!"
            } else if(ret == SDK_NO_ACTIVATED.rawValue) {
                warningLbl.text = "No activated!"
            } else if(ret == SDK_INIT_ERROR.rawValue) {
                warningLbl.text = "Init error!"
            }
        }
        
        SettingsViewController.setDefaultSettings()
        
        personView.delegate = self
        personView.dataSource = self
        personView.separatorStyle = .none
        personView.reloadData()
    }
    
    @IBAction func enroll_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.enrollBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    @IBAction func enroll_touch_cancel(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.enrollBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func enroll_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.enrollBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func identify_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.identifyBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    @IBAction func identify_touch_up(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.identifyBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func identify_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.identifyBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
        
        performSegue(withIdentifier: "camera", sender: self)
    }
 
    
    @IBAction func settings_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.settingsBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    
    @IBAction func settings_touch_up(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.settingsBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func settings_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.settingsBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }

        performSegue(withIdentifier: "settings", sender: self)
    }
    
    @IBAction func about_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.aboutBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    
    @IBAction func about_touch_up(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.aboutBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func about_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.aboutBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }

        performSegue(withIdentifier: "about", sender: self)
    }
    
    @IBAction func brand_clicked(_ sender: Any) {
        let webURL = URL(string: "https://kby-ai.com")
        UIApplication.shared.open(webURL!, options: [:], completionHandler: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        dismiss(animated: true, completion: nil)

        guard let image = info[.originalImage] as? UIImage else {
            return
        }

        let fixed_image = image.fixOrientation()
        let faceBoxes = FaceSDK.faceDetection(fixed_image)
        if(faceBoxes.count == 0) {
            showToast(message: "No face detected!")
            return
        } else if(faceBoxes.count > 1) {
            showToast(message: "Multiple face detected!")
        }
        
        for faceBox in (faceBoxes as NSArray as! [FaceBox]) {
            
            let templates = FaceSDK.templateExtraction(fixed_image, faceBox: faceBox)
            if(templates.isEmpty) {
                continue
            }
            
            let faceImage = fixed_image.cropFace(faceBox: faceBox)
            
            let context = self.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: ViewController.ENTITIES_NAME, in: context)!
            let user = NSManagedObject(entity: entity, insertInto: context)

            let name = "Person" + String(Int.random(in: 10000...20000))
            let face = faceImage!.jpegData(compressionQuality: CGFloat(1.0))
            
            user.setValue(name, forKey: ViewController.ATTRIBUTE_NAME)
            user.setValue(templates, forKey: ViewController.ATTRIBUTE_TEMPLATES)
            user.setValue(face, forKey: ViewController.ATTRIBUTE_FACE)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        personView.reloadData()
        showToast(message: "Person enrolled!")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of cells in the table view
        
        let context = self.persistentContainer.viewContext
        let count = try! context.count(for: NSFetchRequest(entityName: ViewController.ENTITIES_NAME))
        
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the table view cell for the specified index path
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonViewCell
        cell.delegate = self
        cell.indexPath = indexPath

        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ViewController.ENTITIES_NAME)
        do {
            let persons = try context.fetch(fetchRequest) as! [NSManagedObject]
            var rowCount = 0
            for person in persons {
                if(rowCount == indexPath.row) {
                    cell.nameLbl.text = person.value(forKey: ViewController.ATTRIBUTE_NAME) as? String
                    cell.faceImage.image = UIImage(data: person.value(forKey: ViewController.ATTRIBUTE_FACE) as! Data)
                    
                    break
                }
                rowCount = rowCount + 1
            }
        } catch {
            print("Failed fetching: \(error)")
        }
        
        // Customize the cell
        return cell
    }

    // UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func didPersonDelete(_ cell: UITableViewCell) {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ViewController.ENTITIES_NAME)
        let personCell = cell as! PersonViewCell

        do {
            let persons = try context.fetch(fetchRequest) as! [NSManagedObject]
            var rowCount = 0
            for person in persons {
                if(rowCount == personCell.indexPath?.row) {
                    context.delete(person)
                    try context.save()
                    break
                }
                rowCount = rowCount + 1
            }
        } catch {
            print("Failed fetching: \(error)")
        }
        
        self.personView.reloadData()
    }
}


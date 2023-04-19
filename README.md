<p align="center">
  <img src="https://user-images.githubusercontent.com/125717930/225975240-24b9a8ad-8cc6-4d5f-9a91-1435951b0bd7.png" width="120" alt="Nest Logo" />
</p>


# FaceRecognition-iOS

Facial recognition technology is demonstrated here that can enroll and identify individuals while also verifying face liveness in real-time.

The demonstration showcases the capability to enroll individuals from photo galleries on iPhone and identify them in real-time using a camera.

## Screenshots

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/231923322-d675622c-972c-4a10-9a7a-e94607dbf5bb.png" width=300/>
  <img src="https://user-images.githubusercontent.com/125717930/231923339-1cb1d76f-7757-4a18-a8c8-42880a1740a6.png" width=300/>
</p>

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/231923346-9ff7015a-9c68-4984-b7b0-0beb7f7387f4.png" width=300/>
  <img src="https://user-images.githubusercontent.com/125717930/231923352-f9403d52-69e5-4f5d-b5ee-0e48ede8ec6f.png" width=300/>
</p>

## SDK License

The face recognition project relies on kby-ai's SDK, which requires a license for each bundle ID.

- The code below shows how to use the license: https://github.com/kby-ai/FaceRecognition-iOS/blob/40b54da44a0c72c6bef275a060fc6b1ff8b3360c/FaceRecognition/ViewController.swift#L37-L44

- To request a license, please contact us:
```
Email: contact@kby-ai.com

Telegram: @kbyai

WhatsApp: +19092802609

Skype: live:.cid.66e2522354b1049b
```

## About SDK

### Set up
1. Copy the SDK (facesdk.framework folder) to the root folder of your project.

2. Add SDK framework to the project in xcode

> Project Navigator -> General -> Frameworks, Libraries, and Embedded Content

![image](https://user-images.githubusercontent.com/125717930/231925359-ef30b3c0-d2d9-4b32-ae57-80b42b021b91.png)

3. Add the bridging header to your project settings

> Project Navigator -> Build Settings -> Swift Compiler - General

![image](https://user-images.githubusercontent.com/125717930/232944333-9bd57f0c-1a11-4e2e-9a8f-e387323f0919.png)


### Initializing an SDK

- Step One

To begin, you need to activate the SDK using the license that you have received.
```
FaceSDK.setActivation("...") 
```

If activation is successful, the return value will be SDK_SUCCESS. Otherwise, an error value will be returned.

- Step Two

After activation, call the SDK's initialization function.
```
FaceSDK.initSDK()
```
If initialization is successful, the return value will be SDK_SUCCESS. Otherwise, an error value will be returned.

### Face Detection and Liveness Detection

The FaceSDK offers a single function for detecting face and liveness detection, which can be used as follows:
```
let faceBoxes = FaceSDK.faceDetection(image)
```

https://github.com/kby-ai/FaceRecognition-iOS/blob/40b54da44a0c72c6bef275a060fc6b1ff8b3360c/FaceRecognition/CameraViewController.swift#L101-L113

This function takes a single parameter, which is a UIImage object. 
The return value of the function is a list of FaceBox objects. 
Each FaceBox object contains the detected face rectangle, liveness score, and facial angles such as yaw, roll, and pitch.

### Create Templates

The FaceSDK provides a function that can generate a template from a UIImage. This template can then be used to verify the identity of the individual captured in the image.

```
let templates = FaceSDK.templateExtraction(capturedImage, faceBox: faceBox)
```

https://github.com/kby-ai/FaceRecognition-iOS/blob/40b54da44a0c72c6bef275a060fc6b1ff8b3360c/FaceRecognition/CameraViewController.swift#L128-L132

The SDK's template extraction function takes two parameters: a UIImage object and an object of FaceBox. 

The function returns a Data, which contains the template that can be used for person verification.

### Calculation similiarity

The "similarityCalculation" function takes a byte array of two templates as a parameter. 

```
let similarity = FaceSDK.similarityCalculation(templates, templates2: personTemplates)
```

It returns the similarity value between the two templates, which can be used to determine the degree of similarity between the two individuals.

# References

- [Face Liveness Detection - Android](https://github.com/kby-ai/FaceLivenessDetection-Android)
- [Face Liveness Detection - iOS](https://github.com/kby-ai/FaceLivenessDetection-iOS)
- [Face Recognition - Android](https://github.com/kby-ai/FaceRecognition-Android)

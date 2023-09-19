<p align="center">
  <a href="https://play.google.com/store/apps/dev?id=7086930298279250852" target="_blank">
    <img alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/125717930/246971879-8ce757c3-90dc-438d-807f-3f3d29ddc064.png" width=500/>
  </a>  
</p>

👏 Product List

https://github.com/kby-ai/Product

👏  We have published the Face Liveness Detection, Face Recognition SDK and ID Card Recognition SDK for the server.

  - [FaceLivenessDetection-Docker](https://github.com/kby-ai/FaceLivenessDetection-Docker)

  - [FaceRecognition-Docker](https://github.com/kby-ai/FaceRecognition-Docker)

  - [IDCardRecognition-Docker](https://github.com/kby-ai/IDCardRecognition-Docker)

# FaceRecognition-iOS
## Overview
The demo project demonstrates both Face Liveness Detection and Face Recognition Technology.

> The demo is integrated with KBY-AI's Standard Face Mobile SDK.

  | Basic      | Standard | Premium |
  |------------------|------------------|------------------|
  | Face Detection        | Face Detection    | Face Detection |
  | Face Liveness Detection        | Face Liveness Detection    | Face Liveness Detection |
  | Pose Estimation        | Pose Estimation    | Pose Estimation |
  |         | Face Recognition    | Face Recognition |
  |         |         | 68 points Face Landmark Detection |
  |         |         | Face Quality Calculation |
  |         |         | Face Occlusion Detection |
  |         |         | Eye Closure Detection |
  |         |         | Age, Gender Estimation |

> For other solutions, please explore the following:
>
> [Face Liveness Detection - Android(Basic SDK)](https://github.com/kby-ai/FaceLivenessDetection-Android)
> 
> [Face Liveness Detection - iOS(Basic SDK)](https://github.com/kby-ai/FaceLivenessDetection-iOS)
> 
> [Face Recognition - Android(Standard SDK)](https://github.com/kby-ai/FaceRecognition-Android)
> 
> [Face Recognition - iOS(Standard SDK)](https://github.com/kby-ai/FaceRecognition-iOS)
> 
> [Face Recognition - Flutter(Standard SDK)](https://github.com/kby-ai/FaceRecognition-Flutter)
> 
> [Face Recognition - React-Native(Standard SDK)](https://github.com/kby-ai/FaceRecognition-React-Native)
>
> [Face Attribute - Android(Premium SDK)](https://github.com/kby-ai/FaceAttribute-Android)
> 
> [Face Attribute - iOS(Premium SDK)](https://github.com/kby-ai/FaceAttribute-iOS)

## Download on the App Store

<a href="https://apps.apple.com/us/app/kby-ai-face-recognition/id6448648922" target="_blank">
  <img alt="" src="https://user-images.githubusercontent.com/125717930/235276083-d20fe057-214d-497c-a431-4569bbeed2fe.png" height=80/>
</a>

## Screenshots

<p float="left">
  <img src="https://github.com/kby-ai/FaceRecognition-iOS/assets/125717930/ef13ae4c-0347-4001-aa05-4150cfbf94e2" width=300/>
  <img src="https://github.com/kby-ai/FaceRecognition-iOS/assets/125717930/12f7d09e-65a1-441b-a01f-e1eda8c1fab2" width=300/>
</p>

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/232952720-dbe1b61e-e993-4caa-bb52-074f1779df39.png" width=300/>
  <img src="https://user-images.githubusercontent.com/125717930/232952741-ecbbf7fe-5c0f-41ff-b7df-7f119e016d0a.png" width=300/>
</p>

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/232952852-12e195a0-d2df-473c-8cc2-e5292adca14d.png" width=300/>
  <img src="https://github.com/kby-ai/FaceRecognition-iOS/assets/125717930/ec295406-07a7-49e6-b8e8-b5b94e47946b" width=300/>
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


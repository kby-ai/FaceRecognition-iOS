<p align="center">
  <a href="https://play.google.com/store/apps/dev?id=7086930298279250852" target="_blank">
    <img alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/125717930/246971879-8ce757c3-90dc-438d-807f-3f3d29ddc064.png" width=500/>
  </a>  
</p>

#### 📚 Product & Resources - [Here](https://github.com/kby-ai/Product)
#### 🛟 Help Center - [Here](https://docs.kby-ai.com)
#### 💼 KYC Verification Demo - [Here](https://github.com/kby-ai/KYC-Verification-Demo-Android)
#### 🙋‍♀️ Docker Hub - [Here](https://hub.docker.com/u/kbyai)

# FaceRecognition-iOS
## Overview
This repository demonstrates both `face liveness detection` and `face recognition` technology developed by `KBY-AI`.

> In this repository, we integrated `KBY-AI`'s both `face liveness detection` and `face recognition` technology into `iOS` platform.</br>
### ◾FaceSDK(Mobile) Details

  | Basic      | 🔽 Standard | Premium |
  |------------------|------------------|------------------|
  | Face Detection        | <b>Face Detection</b>    | Face Detection |
  | Face Liveness Detection        | <b>Face Liveness Detection</b>    | Face Liveness Detection |
  | Pose Estimation        | <b>Pose Estimation</b>    | Pose Estimation |
  |         | <b>Face Recognition</b>    | Face Recognition |
  |         |         | 68 points Face Landmark Detection |
  |         |         | Face Quality Calculation |
  |         |         | Face Occlusion Detection |
  |         |         | Eye Closure Detection |
  |         |         | Age, Gender Estimation |

### ◾FaceSDK(Mobile) Product List
  | No.      | Repository | SDK Details |
  |------------------|------------------|------------------|
  | 1        | [Face Liveness Detection - Android](https://github.com/kby-ai/FaceLivenessDetection-Android)    | Basic SDK |
  | 2        | [Face Liveness Detection - iOS](https://github.com/kby-ai/FaceLivenessDetection-iOS)    | Basic SDK |
  | 3        | [Face Recognition - Android](https://github.com/kby-ai/FaceRecognition-Android)    | Standard SDK |
  | ➡️        | <b>[Face Recognition - iOS](https://github.com/kby-ai/FaceRecognition-iOS)</b>    | <b>Standard SDK</b> |
  | 5        | [Face Recognition - Flutter](https://github.com/kby-ai/FaceRecognition-Flutter)        | Standard SDK |
  | 6        | [Face Recognition - Ionic-Cordova](https://github.com/kby-ai/FaceRececogniion-Ionic-Cordova)        | Standard SDK |
  | 7        | [Face Recognition - React-Native](https://github.com/kby-ai/FaceRecognition-React-Native)        | Standard SDK |
  | 8        | [Face Attribute - Android](https://github.com/kby-ai/FaceAttribute-Android)        | Premium SDK |
  | 9        | [Face Attribute - iOS](https://github.com/kby-ai/FaceAttribute-iOS)        | Premium SDK |
  | 10        | [Face Attribute - Flutter](https://github.com/kby-ai/FaceAttribute-Flutter)        | Premium SDK |


 > To get `Face SDK(server)`, please visit products [here](https://github.com/kby-ai/Product).<br/>

## Download on the App Store

<a href="https://apps.apple.com/us/app/kby-ai-face-recognition/id6448648922" target="_blank">
  <img alt="" src="https://user-images.githubusercontent.com/125717930/235276083-d20fe057-214d-497c-a431-4569bbeed2fe.png" height=80/>
</a>

## Performance Video

You can visit our YouTube video [here](https://www.youtube.com/watch?v=M7t_dpT-hOI) to see how well our demo app works.</br></br>
[![Face Recognition Android](https://img.youtube.com/vi/M7t_dpT-hOI/0.jpg)](https://www.youtube.com/watch?v=M7t_dpT-hOI)

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

This repo integrated `KBY-AI`'s `face recognition SDK`, which requires a license for each `bundle ID` from `iOS` project.

- The code below shows how to use the license: https://github.com/kby-ai/FaceRecognition-iOS/blob/40b54da44a0c72c6bef275a060fc6b1ff8b3360c/FaceRecognition/ViewController.swift#L37-L44

- To request a license, please ping us on the following contact address:
#### Please contact us:
🧙`Email:` contact@kby-ai.com</br>
🧙`Telegram:` [@kbyai](https://t.me/kbyai)</br>
🧙`WhatsApp:` [+19092802609](https://wa.me/+19092802609)</br>
🧙`Skype:` [live:.cid.66e2522354b1049b](https://join.skype.com/invite/OffY2r1NUFev)</br>
🧙`Facebook:` https://www.facebook.com/KBYAI</br>

## About SDK

### Set up
1. Copy the SDK (`facesdk.framework` folder) to the `root` folder in your project.

2. Add `SDK framework` to the project in `Xcode`.

> Project Navigator -> General -> Frameworks, Libraries, and Embedded Content

![image](https://user-images.githubusercontent.com/125717930/231925359-ef30b3c0-d2d9-4b32-ae57-80b42b021b91.png)

3. Add the bridging header to your project settings

> Project Navigator -> Build Settings -> Swift Compiler - General

![image](https://user-images.githubusercontent.com/125717930/232944333-9bd57f0c-1a11-4e2e-9a8f-e387323f0919.png)


### Initializing an SDK

- Step One

To begin, you need to activate the SDK using the license that you have received.
```swift
FaceSDK.setActivation("...") 
```

If activation is successful, the return value will be `SDK_SUCCESS`. Otherwise, an error value will be returned.

- Step Two

After activation, call the `SDK`'s initialization function.
```swift
FaceSDK.initSDK()
```
If initialization is successful, the return value will be `SDK_SUCCESS`. Otherwise, an error value will be returned.

### Face Detection and Liveness Detection

The `FaceSDK` offers a single function for `face detection` and `face liveness detection`, which can be used as follows:
```swift
let faceBoxes = FaceSDK.faceDetection(image)
```

https://github.com/kby-ai/FaceRecognition-iOS/blob/40b54da44a0c72c6bef275a060fc6b1ff8b3360c/FaceRecognition/CameraViewController.swift#L101-L113

This function takes a single parameter, which is a `UIImage` object. 
The return value of the function is a list of `FaceBox` objects. 
Each `FaceBox` object contains the detected face rectangle, liveness score, and facial angles such as `yaw`, `roll`, and `pitch`.

### Create Templates

The `FaceSDK` provides a function that can generate a `template` from a `UIImage`. This `template` can then be used to verify the identity of the individual image captured.

```swift
let templates = FaceSDK.templateExtraction(capturedImage, faceBox: faceBox)
```

https://github.com/kby-ai/FaceRecognition-iOS/blob/40b54da44a0c72c6bef275a060fc6b1ff8b3360c/FaceRecognition/CameraViewController.swift#L128-L132

The `SDK`'s `template` extraction function takes two parameters: a `UIImage` object and an object of `FaceBox`. 

The function returns a `Data`, which contains the `template` that can be used for person verification.

### Calculation similiarity

The `similarityCalculation` function takes a byte array of two `template`s as a parameter. 

```swift
let similarity = FaceSDK.similarityCalculation(templates, templates2: personTemplates)
```

It returns the similarity value between the two `template`s, which can be used to determine the degree of similarity between the two individuals.


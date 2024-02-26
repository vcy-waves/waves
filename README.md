# Waves🏖️
An application that provide users to share the gorgeous ocean with other,
but while the place getting polluted, we co-host event to save this ocean together.

## Demo Video🎞️
Click on [link](https://)

## Before You Start▶️
- Make sure your flutter / dart environment is above 3.16.9 / 3.2.6
- if you are Ios user, make sure your ios version is 10 or higher
- if you are android user, make sure your android version / compileSDK is 12 / 34 or higher

## Problem Solving
We go to 6 different beaches in person to list out what problem users are facing.
And due to the policy of **'
淨灘合作社' in New Taipei City**, we classify users by visitor and store



| 六塊厝 | 白沙灣 | 深奧鐵道自行車 |象鼻岩|台北港|淺水灣|
| -------- | -------- | -------- |-------- |-------- |-------- |
|![1](https://github.com/vcy-waves/waves/blob/main/readme%20photo/six.jpg?raw=true)|![2](https://raw.githubusercontent.com/vcy-waves/waves/main/readme%20photo/bay.jpg)|![3](https://github.com/vcy-waves/waves/blob/main/readme%20photo/shen.jpg?raw=true)|![4](https://github.com/vcy-waves/waves/blob/main/readme%20photo/beee.jpg?raw=true)|![5](https://github.com/vcy-waves/waves/blob/main/readme%20photo/taipei%20port.jpg?raw=true)|![6](https://github.com/vcy-waves/waves/blob/main/readme%20photo/chien.jpg?raw=true)





### For Store🏘️
- Visitors leave trash in front of my store without calling 'Environmental Protection Agency', and it smells unpleasant.
  - app : we provide phone number of agency, users can click a button then navigator page to notice agency come to bring out the trash.
- To many visitors come in same time, but we don't have that much cleaning tools.
  - We only publish notification to those user that close to the place or those who allow any notification so that we can control the stream of visitors to borrow tools.

### For Visitors👨‍👩‍👧‍👦
- We wanted to clean up this beach while visiting, but we didn't bring the clean tools.
  - app : search nearby specific store with tag in map to borrow.
- The ocean is wide, I cannot tidy up this place by myself.
  - app : publish post and send notifications to users close to you, pick up a time to clean it up together !
- I want to search a beautiful place to take a rest
  - app : we classify ocean with 5 degrees, while other user publish post with no pollution ocean, we will notify user come to visit.



## Features
- publish post and host event to clean up beach
- navigate to specific ocean
- notification while publishing post and determine who to receive it by distance
- searching nearby store by map with tags 
- whether the ocean is clean recognition using ML

## ScreenShots


| Home Page                                             | Search Store                                          | Host Event Page                                       | Search Event Page                                     |
|:----------------------------------------------------- |:----------------------------------------------------- |:----------------------------------------------------- | ----------------------------------------------------- |
| ![608694_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/homepage.jpg?raw=true) | ![608692_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/postpage.jpg?raw=true) | ![608693_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/search%20site.jpg?raw=true) | ![608691_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/search%20post.jpg?raw=true) |

| Profile Page                                          | Login Page                                            | Register Page                                         |                     Click On Tag                      |
| ----------------------------------------------------- | ----------------------------------------------------- |:----------------------------------------------------- |:-----------------------------------------------------:|
| ![608690_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/profilepage.jpg?raw=true) | ![608688_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/login.jpg?raw=true) | ![608687_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/register.jpg?raw=true) | ![608689_0](https://github.com/vcy-waves/waves/blob/main/readme%20photo/clickon.jpg?raw=true) |
## Features in Details




### Post 
Whenever you saw any polluted ocean or gorgeous beach in New Taipei City, 
you can take a picture and make a post to invite others come to visit or 
clean up this ocean together.

- Publish Post
  - post with your current location and picture 
  - **Our AI model will determine whether the ocean is clean or not so as to send notification to other users.**
- Navigator to the post location by map in the app
- Interact with other users (scrolling others post and leave with your like)

Examples...

### Search Collaborated Store
- open Google Map to search nearby store in order to borrow gloves or other cleaning tools.
- The Map is already tag collaborated stores

Examples..

### Notification
- Our app will send notification by rules below
  - send to user that close to the sender location
    - driving cost less than 30 mins (car)
  - user who allow any notification
- Notification will send with below information
  - location
  - simple description about this location
  - how far away by this place 

Examples ...

## Google Technologies Usage 
- Flutter / Dart
- Firebase
  - Storage
  - Firestore
  - Authentication
- Google Map Platform
- Teachable Machine

### In Detail
- App 
  - Flutter / Dart
- NotificationService 
  - flutter_local_notifications
  - firebase
- Distance / Location Service
  - Google Map Platform
    - Distance Matrix API
    - Geocoding API
- Posts
  - Firebase
- AI Model
  - Teachable Machine

# Android Studio in Gitpod
A Docker image designed to run Android Studio 2023.1.1 as a cloud-based IDE in gitpod.<br>
<center><img src='images/Android-Studio-Hedgehog.png'></center>

## Current status
-   Works fine.
-   Can't store settings/downloaded plugins/SDKs etc.
-   Once the gitpod is stopped again you need to configure it in next startup.

## Usage
### Method 1: 
1. Just click the button to open to run in Gitpod:<br><br>
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/rijj1/Android_Studio_in_Gitpod)

2. In the terminal where you have the container running, enter `android_studio`, and Android Studio should start in the browser tab.

### Method 2:
1. Just run the command in the terminal:
````bash
docker run -it --rm -p 6080:6080 rijj1/android_studio_in_gitpod:v1.0
````
2. In the terminal where you have the container running, enter `android_studio`, and Android Studio should start in the browser tab.

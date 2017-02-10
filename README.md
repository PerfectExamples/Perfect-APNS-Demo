# Apple Push Notification Service (APNS) Demo

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involved with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>

This repository holds two projects, designed to show you how to implement Apple's Push Notifications Service server-side with Perfect. 

The included example is an iOS app that will receive the notifications, but the procedure for macOS is the same server-side, as well as very similar in the actual app. 

The objects in the API & Webapp are separated by function:

- NewsItem is the model we are using for a notification
- Device, which holds the model for a device token. 
- DataService stores the device tokens in memory, as well as all the received notifications. This serves as a single memory-held instance for both device tokens and recent notifications, which can be accessed from any view. This is accomplished by using only initialized variables in the class, as well as creating an instance of the class held by itself `static let instance = DataService()`. In practice this is commonly referred to as creating a "singleton" (meaning that there is only ever one instance of the class used). Many people also call this a data service. Since you never need to initialize an instance of it, you can simply refer to the class.instance to use the shared resources, i.e. `DataService.instance.notify(title: "Test", message: "Notification")`. This is especially useful in tableView data. 
- Handlers hold the required handlers
- Notifier holds the struct that decodes JSON form a request, sends a message, then formats a response for the handler to deliver back to the client


## Compatibility with Swift

The master branch of this project currently compiles with **Xcode 8.2/8.3 beta 2** or the **Swift 3.0.2/3.1** toolchains on Ubuntu. 

## Setup

### Getting a key

Prior to running the API, you must add your own notifications key from the Apple Developer Portal and change the identifiers to match. If you are not familiar with this process and/or do not already have one, head over to [https://developer.apple.com/account](https://developer.apple.com/account) and click on Certificates, Identifiers, & Profiles:

![Apple Developer Portal](https://github.com/PerfectExamples/Perfect-APNS-Demo/raw/master/Supporting/certificates.png)

From there, click on the "+" button in the upper right hand corner, which will take you to this screen:

![Add New Developer APNS Key](https://github.com/PerfectExamples/Perfect-APNS-Demo/raw/master/Supporting/new-key.png)

Make sure to select the box that says "Apple Push Notification Authentication Key (Sandbox & Production)" (Key **NOT** SSL)

From there, you can simply download the key:

![Download APNS Key](https://github.com/PerfectExamples/Perfect-APNS-Demo/raw/master/Supporting/download-key.png)

BE SURE TO DOWNLOAD AND RETAIN THE FILE, AS THIS IS THE ONLY OPPORTUNITY YOU HAVE TO DOWNLOAD IT. If you lose it, you will have to revoke it and generate a new one. 

## Building & Running the Backend/API

The following will clone and build an empty starter project:

```
git clone https://github.com/PerfectExamples/Perfect-APNS-Demo.git
cd Perfect-APNS-Demo/Backend/
```

Once you have the project, your fist step is to make a new directory in the Backend folder called keys/. Next, take your APNS key (either one you already had or from the steps above) and place it inside this folder. 

After that, open up main.swift and modify the following section of code:

```
let apnsKeyIdentifier = "L5PQ5652T4"
let apnsTeamIdentifier = "8VF4S3W85G"
let apnsPrivateKey = "./keys/APNsAuthKey_L5PQ5652T4.p8"
```

`apnsKeyIdentifier` should be the same as the identifier inside of _.p8 on the keyfile you downloaded. i.e. `"APNsAuthKey_L5PQ5652T4.p8"` becomes `"L5PQ5652T4"`. `apnsTeamIdentifier` should be your team identifier. If you do not know what this is, you can find it at [https://developer.apple.com/account/#/membership/](https://developer.apple.com/account/#/membership/). Finally, you need to specify the path to your keyfile. If you followed the steps above, that should mean simply changing the filename in the path above. 

Once you have all that information changed, you are ready to start the server:

```
swift build
.build/debug/Perfect-APNS
```

You should see the following output:

```
[INFO] Starting HTTP server localhost on 0.0.0.0:8181
```

This means the server is running and waiting for connections. Access the routes at [http://0.0.0.0:8181/](http://0.0.0.0:8181/). Hit control-c to terminate the server.

### IMPORTANT NOTE ABOUT XCODE FOR THE BACKEND

If you choose to generate an Xcode Project by running `swift package generate-xcodeproj` inside the ./Backend/ directory, you **MUST** change to the executable target **AND** setup a custom working directory wherever you cloned the project. 

![Proper Xcode Setup](https://github.com/PerfectExamples/Perfect-APNS-Demo/raw/master/Supporting/xcode.png)

## Testing

### IMPORTANT NOTE ABOUT TESTING

You must build and run the companion iOS app ON A PHYSICAL iOS DEVICE which is connected to the internet. The simulator will not register itself remotely with Apple's servers and notifications will not be delivered to it. 

### Building and running the iOS App. 

Open the Perfect News.xcodeproj file located in the project directory at `./Perfect\ News`

Open Config.swift. Observing the line that says `let apiEndpoint = "http://10.0.1.11:8181"`, change `10.0.1.11` to your computer's local IP address or the IP of the server/machine that you are running the backend on. This must be accessible to the iOS device either over your local network or the web.

Make sure your devices is plugged in and unlocked. Wait forever for symbols to process if required.

Build and run on your device. 

### Actually Testing

If the backend is running while you built and ran the iOS app, then the device should have registered with Apple and sent its device key to the backend server. You will see a console output in the backend like:

```
▿ Perfect_APNS.Device #0
  - _deviceToken: "d56335564fed3e57382c50bda86f023d18c0faaa5e0054378349111111111111"
```

This means that the device has been successfully registered, and the backend now has it's key stored. The backend stores these tokens in memory, so if you stop the backend at any time, you will have to quit and restart the iOS app so that it transmits it key to the backend. 

To make a test notification, visit [http://0.0.0.0:8181/](http://0.0.0.0:8181/) in your browser. It should look like this:

![APNS Demo Backend](https://github.com/PerfectExamples/Perfect-APNS-Demo/raw/master/Supporting/notification-sender.png)

Fill out the form fields, and press the Notify! Button to send a test notification. You should get a popup notification on success:

![APNS Push Sucess](https://github.com/PerfectExamples/Perfect-APNS-Demo/raw/master/Supporting/pusher-success.png)

The backend has three routes:

- / is the notification pusher
- /register/device is the API endpoint that the iOS app sends its token to
- /notify is the API endpoint that the notification pusher at / uses in order to actually send notifications. This is done though and Ajax call found in the script at `./Backend/webroot/js/notifier.js`

If you are successful, you should see different behavior in the iOS app depending on its state. If the application is open, you will see an alert with the notification, as well as the item populating into the table view. If the app is closed, you should see a push notification in the standard iOS fashion, which when opened, will produce the same effect as if the app were open when the notification was delivered. 

Notification history is stored in memory, so a full quit or rebuild of the app will erase its history, as will the clear button on the top right of the table view. 

## Issues

We are transitioning to using JIRA for all bugs and support related issues, therefore the GitHub issues has been disabled.

If you find a mistake, bug, or any other helpful suggestion you'd like to make on the docs please head over to [http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1) and raise it.

A comprehensive list of open issues can be found at [http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)



## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).

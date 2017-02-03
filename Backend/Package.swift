import PackageDescription

let package = Package(
    name: "Perfect-APNS",
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url:"https://github.com/PerfectlySoft/Perfect-Notifications.git", majorVersion: 2, minor: 0)
    ]
)

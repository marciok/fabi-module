import PackageDescription

let package = Package(
    name: "fabi-module",
    dependencies: [
        .Package(url: "../v8Wrap", majorVersion: 9)
    ]
    
)


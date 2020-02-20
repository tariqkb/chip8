// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chip8",
    products: [
        .executable(
            name: "Chip8",
            targets: ["Chip8"]),
//        .library(
//            name: "Chip8",
//            targets: ["Chip8"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/tbugrara/UInt4", from: "1.0.0"),
        .package(url: "https://github.com/SwiftGL/OpenGL.git", from: "3.0.0"),
        .package(url: "https://github.com/SwiftGL/Math.git", from: "3.0.0"),
        .package(url: "https://github.com/SwiftGL/Image.git", from: "2.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Chip8Lib",
            dependencies: ["UInt4", "CGLFW3", "SGLOpenGL", "SGLImage", "SGLMath", "SDL2"]),
        .target(
            name: "Chip8",
            dependencies: ["Chip8Lib"]),
        .testTarget(
            name: "Chip8LibTests",
            dependencies: ["Chip8Lib"]),
        .systemLibrary(
            name: "CGLFW3",
            pkgConfig: "glfw3",
            providers: [
                .brew(["glfw"]),
                .apt(["glfw"]),
            ]
        ),
        .systemLibrary(
            name: "SDL2",
            pkgConfig: "sdl2",
            providers: [
                .brew(["sdl2"]),
                .apt(["sdl2"]),
            ]
        )
    ]
)

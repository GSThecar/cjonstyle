import ProjectDescription

let project = Project(
    name: "cjonstyle",
    targets: [
        .target(
            name: "cjonstyle",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.cjonstyle",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["cjonstyle/Sources/**"],
            resources: ["cjonstyle/Resources/**"],
            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Then", package: "Then"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxCocoa"),
                .product(name: "RxDataSources", package: "RxDataSources"),
                .product(name: "SnapKit", package: "SnapKit")
            ]
        ),
        .target(
            name: "cjonstyleTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.cjonstyleTests",
            infoPlist: .default,
            sources: ["cjonstyle/Tests/**"],
            resources: [],
            dependencies: [.target(name: "cjonstyle")]
        ),
    ]
)

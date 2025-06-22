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
                .external(name: "Kingfisher"),
                .external(name: "Then"),
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "RxDataSources"),
                .external(name: "SnapKit")
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

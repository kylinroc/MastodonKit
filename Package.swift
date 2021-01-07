// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MastodonAPI",
    products: [.library(name: "MastodonAPI", targets: ["MastodonAPI"])],
    dependencies: [.package(url: "https://github.com/li-bei/swift-http-link-header", from: "0.1.0")],
    targets: [
        .target(name: "MastodonAPI", dependencies: [
            .product(name: "HTTPLinkHeader", package: "swift-http-link-header"),
        ]),
    ]
)

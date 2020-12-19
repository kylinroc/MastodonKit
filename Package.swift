// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MastodonAPI",
    products: [.library(name: "MastodonAPI", targets: ["MastodonAPI"])],
    targets: [.target(name: "MastodonAPI")]
)

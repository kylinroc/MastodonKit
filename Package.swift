// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MastodonKit",
    products: [.library(name: "MastodonKit", targets: ["MastodonKit"])],
    targets: [.target(name: "MastodonKit")]
)

// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "MastodonKit",
    products: [.library(name: "MastodonKit", targets: ["MastodonKit"])],
    targets: [.target(name: "MastodonKit")]
)

// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MastodonKit",
    platforms: [.iOS(.v13)],
    products: [.library(name: "MastodonKit", targets: ["MastodonKit"])],
    targets: [.target(name: "MastodonKit")]
)

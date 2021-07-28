// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NewsUI",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "SearchFeature", targets: ["SearchFeature"]),
    .library(name: "HeadlinesFeature", targets: ["HeadlinesFeature"]),
    .library(name: "SourcesFeature", targets: ["SourcesFeature"])
  ],
  dependencies: [
    .package(url: "https://github.com/mtfum/NewsAPI.git", from: "0.1.0"),
    .package(url: "https://github.com/apple/swift-collections.git", from: "0.0.1"),
  ],
  targets: [
    .target(name: "AppComponent", dependencies: ["NewsAPI"]),
    .target(name: "AppFeature", dependencies: ["SearchFeature", "HeadlinesFeature", "SourcesFeature"]),
    .target(name: "NewsClient", dependencies: ["NewsAPI"]),
    .target(name: "SearchFeature", dependencies: ["AppComponent", "NewsClient", .product(name: "OrderedCollections", package: "swift-collections")]),
    .target(name: "HeadlinesFeature", dependencies: ["AppComponent", "NewsClient"]),
    .target(name: "SourcesFeature", dependencies: ["AppComponent", "NewsClient"])
  ]
)

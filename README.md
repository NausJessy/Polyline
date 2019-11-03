# Polyline

Polyline is an utility library for encoding and decoding polylines as defined by the [Polyline Algorithm](https://developers.google.com/maps/documentation/utilities/polylinealgorithm).

## Requirements

* iOS 10.0+ / macOS 10.12+ / tvOS 10.0+
* Xcode 11.1
* Swift 5.1

## Installation

You can use [Swift Package Manager](https://swift.org/package-manager/) and specify dependency in Package.swift by adding this:

```swift
.package(url: "https://https://gitlab.com/panache_team/ios/polyline.git", .upToNextMinor(from: "1.0.0"))
```

## Usage

Start by importing the `Polyline` library.

```swift
import Polyline
```

To create a `Polyline`, define an array of coordinate and call the `encode(path:)` method.

```swift
let coordinates = [
    CLLocationCoodinate2D(38.5, -120.2),
    CLLocationCoodinate2D(40.7, -120.95),
    CLLocationCoodinate2D(43.252, -126.453)
]
encode(path: coordinates)
```

To create an array of coordinate, define an `Polyline` and call the `decode(polyline:)` method.

```swift
let polyline: Polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
decode(polyline: polyline)
```
## Changelog

See [CHANGELOG](./CHANGELOG) for details.

## License

Polyline is released under the MIT license. See [LICENSE](./LICENSE) for details.

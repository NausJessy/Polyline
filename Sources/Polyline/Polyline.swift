import CoreLocation

/// A polyline stores a series of coordinates as a single string.
public typealias Polyline = String

// MARK: - Encoding

/// Encode a path (i.e. an array of `CLLocation` objects) into a `Polyline`.
///
/// - Parameter path: A path to encode.
///
/// - Returns: The encode path as a `Polyline`.
public func encode(path: [CLLocation]) -> Polyline {
    encode(path: path.map { $0.coordinate })
}

/// Encode a path (i.e. an array of `CLLocationCoordinate2D` objects) into a `Polyline`.
///
/// - Parameter path: A path to encode.
///
/// - Returns: The encode path as a `Polyline`.
public func encode(path: [CLLocationCoordinate2D]) -> Polyline {
    var lastLat = 0, lastLng = 0
    
    return path.reduce("", { result, point in
        let lat = Int(point.latitude * pow(10, 5))
        let lng = Int(point.longitude * pow(10, 5))
        
        defer { lastLat = lat; lastLng = lng }
        
        return result + encode(value: lat - lastLat) + encode(value: lng - lastLng)
    })
}

/// Encode a value into a `Polyline`.
///
/// - Parameter value: The value to encode.
///
/// - Returns: A `Polyline`.
private func encode(value: Int) -> Polyline {
    var result: String = ""
    
    var v = value < 0 ? ~(value << 1) : value << 1
    while v >= 0x20 {
        let char = Character(Unicode.Scalar((0x20 | (v & 0x1f)) + 63)!)
        result.append(char)
        v >>= 5
    }
    
    result.append(Character(Unicode.Scalar(v + 63)!))
    
    return result
}

// MARK: - Decoding

/// Decode a polyline into an array of `CLLocation` objects.
///
/// - Parameter polyline: A `Polyline` to decode.
///
/// - Returns: An array of decoded `CLLocation` objects.
public func decode(polyline: Polyline) -> [CLLocation] {
    let coordinates: [CLLocationCoordinate2D] = decode(polyline: polyline)
    return coordinates.map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) }
}

/// Decode a polyline into an array of `CLLocationCoordinate2D` objects.
///
/// - Parameter polyline: A `Polyline` to decode.
///
/// - Returns: An array of decoded `CLLocationCoordinate2D` objects.
public func decode(polyline: Polyline) -> [CLLocationCoordinate2D] {
    let length = polyline.count
    
    var path: [CLLocationCoordinate2D] = []
    
    var offset = 0
    var lat = 0
    var lng = 0
    
    while (offset < length) {
        var result = 1
        var shift = 0
        var b = 0
        
        repeat {
            b = Int(polyline[String.Index(utf16Offset: offset, in: polyline)].unicodeScalars.first!.value) - 63 - 1
            offset += 1
            result += b << shift
            shift += 5
        } while b >= 0x1f
        
        lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1)
        
        result = 1
        shift = 0
        
        repeat {
            b = Int(polyline[String.Index(utf16Offset: offset, in: polyline)].unicodeScalars.first!.value) - 63 - 1
            offset += 1
            result += b << shift
            shift += 5
        } while b >= 0x1f
        
        lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1)
        
        path.append(.init(latitude: Double(lat) * 1e-5, longitude: Double(lng) * 1e-5))
    }
    
    return path
}

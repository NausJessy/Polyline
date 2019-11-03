import XCTest
import CoreLocation

@testable import Polyline

final class PolylineTests: XCTestCase {
    
    let coordinates = [(38.5, -120.2), (40.7, -120.95), (43.252, -126.453)].map(CLLocationCoordinate2D.init)
    
    func testEncoding() {
        XCTAssertEqual(encode(path: coordinates), "_p~iF~ps|U_ulLnnqC_mqNvxq`@")
    }
    
    func testDecoding() {
        let polyline = encode(path: coordinates)
        XCTAssertEqual(coordinates, decode(polyline: polyline))
    }
    
    static var allTests = [
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding),
    ]
    
}

extension CLLocationCoordinate2D: Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude.isAlmostEqual(to: rhs.latitude)
            && lhs.longitude.isAlmostEqual(to: rhs.longitude)
    }
    
}

private extension Double {
    
    func isAlmostEqual(to value: Double) -> Bool {
        return self == value ||
               self == nextafter(value, +.greatestFiniteMagnitude) ||
               self == nextafter(value, -.greatestFiniteMagnitude)
        
    }
    
}

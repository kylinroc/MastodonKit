@testable import MastodonKit
import XCTest

final class ApplicationTests: XCTestCase {
    func testDecoding() {
        let data = """
            {
              "id": "563419",
              "name": "test app",
              "website": null,
              "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
              "client_id": "TWhM-tNSuncnqN7DBJmoyeLnk6K3iJJ71KKXxgL1hPM",
              "client_secret": "ZEaFUFmF0umgBX1qKJDjaU99Q31lDkOU8NutzTOoliw",
              "vapid_key": "BCk-QqERU0q-CfYZjcuB6lnyyOYfJ2AifKqfeGIm7Z-HiTU5T9eTG5GxVA0_OH5mMlI4UkkDTpaZwozy0TzdZ2M="
            }
            """
            .data(using: .utf8)!

        let application = try! Client.makeJSONDecoder().decode(Application.self, from: data)
        XCTAssertEqual(application.name, "test app")
        XCTAssertEqual(application.website, nil)
        XCTAssertEqual(application.clientID, "TWhM-tNSuncnqN7DBJmoyeLnk6K3iJJ71KKXxgL1hPM")
        XCTAssertEqual(application.clientSecret, "ZEaFUFmF0umgBX1qKJDjaU99Q31lDkOU8NutzTOoliw")
        XCTAssertEqual(application.vapidKey, "BCk-QqERU0q-CfYZjcuB6lnyyOYfJ2AifKqfeGIm7Z-HiTU5T9eTG5GxVA0_OH5mMlI4UkkDTpaZwozy0TzdZ2M=")
        XCTAssertEqual(application.redirectURI, "urn:ietf:wg:oauth:2.0:oob")
    }
}

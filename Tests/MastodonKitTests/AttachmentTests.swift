@testable import MastodonKit
import XCTest

final class AttachmentTests: XCTestCase {
    func testDecoding() {
        let data = """
            {
              "id": "22345792",
              "type": "image",
              "url": "https://files.mastodon.social/media_attachments/files/022/345/792/original/57859aede991da25.jpeg",
              "preview_url": "https://files.mastodon.social/media_attachments/files/022/345/792/small/57859aede991da25.jpeg",
              "remote_url": null,
              "text_url": "https://mastodon.social/media/2N4uvkuUtPVrkZGysms",
              "meta": {
                "original": {
                  "width": 640,
                  "height": 480,
                  "size": "640x480",
                  "aspect": 1.3333333333333333
                },
                "small": {
                  "width": 461,
                  "height": 346,
                  "size": "461x346",
                  "aspect": 1.3323699421965318
                },
                "focus": {
                  "x": -0.27,
                  "y": 0.51
                }
              },
              "description": "test media description",
              "blurhash": "UFBWY:8_0Jxv4mx]t8t64.%M-:IUWGWAt6M}"
            }
            """
            .data(using: .utf8)!

        let attachment = try! Client.makeJSONDecoder().decode(Attachment.self, from: data)
        XCTAssertEqual(attachment.id, "22345792")
        XCTAssertEqual(attachment.type, .image)
        XCTAssertEqual(attachment.url, URL(string: "https://files.mastodon.social/media_attachments/files/022/345/792/original/57859aede991da25.jpeg"))
        XCTAssertEqual(attachment.previewURL, URL(string: "https://files.mastodon.social/media_attachments/files/022/345/792/small/57859aede991da25.jpeg"))
        XCTAssertEqual(attachment.remoteURL, nil)
        XCTAssertEqual(attachment.textURL, URL(string: "https://mastodon.social/media/2N4uvkuUtPVrkZGysms"))
        XCTAssertEqual(attachment.description, "test media description")
        XCTAssertEqual(attachment.blurhash, "UFBWY:8_0Jxv4mx]t8t64.%M-:IUWGWAt6M}")
    }
}

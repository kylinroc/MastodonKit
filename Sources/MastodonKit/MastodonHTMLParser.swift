import Foundation

public final class MastodonHTMLParser: NSObject {
    private let html: String
    private var result: String!

    public init(html: String) {
        self.html = html
    }

    public func parse() -> String {
        result = ""
        let data = "<html>\(html)</html>".data(using: .utf8)!
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return result
    }
}

extension MastodonHTMLParser: XMLParserDelegate {
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        result += string
    }
}

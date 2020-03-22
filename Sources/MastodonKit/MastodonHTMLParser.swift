#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

import Foundation

public final class MastodonHTMLParser: NSObject {
    private struct Element {
        let name: String
        let attributes: [String: String]
        let location: Int

        var `class`: String? { attributes["class"] }

        var href: URL? {
            guard let hrefString = attributes["href"] else {
                return nil
            }

            return URL(string: hrefString)
        }
    }

    private let html: String
    private var result: NSMutableAttributedString!
    private var elements: [Element] = []

    public init(html: String) {
        self.html = html
    }

    public func parse() -> NSMutableAttributedString {
        result = NSMutableAttributedString()
        let parser = XMLParser(data: processedHTMLData())
        parser.delegate = self
        parser.parse()
        result.trimCharacters(in: .whitespacesAndNewlines)
        return result
    }

    private func processedHTMLData() -> Data {
        let html = self.html
            .replacingOccurrences(of: "<br>", with: "<br />")
            .replacingOccurrences(of: "&nbsp;", with: " ")
        return "<html>\(html)</html>".data(using: .utf8)!
    }
}

extension MastodonHTMLParser: XMLParserDelegate {
    public func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?,
        attributes: [String: String] = [:]
    ) {
        let element = Element(name: elementName, attributes: attributes, location: result.length)
        elements.append(element)

        switch element.name {
        case "br":
            result.append("\n")
        case "p":
            if result.length > 0 {
                result.append("\n\n")
            }
        default:
            break
        }
    }

    public func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?
    ) {
        let element = elements.removeLast()
        #if canImport(AppKit) || canImport(UIKit)
        switch element.name {
        case "a":
            guard let href = element.href else {
                break
            }

            let location = element.location
            result.addAttribute(.link, value: href, range: .init(location: location, length: result.length - location))
        default:
            break
        }
        #endif
    }

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let element = elements.last!
        guard element.class != "invisible" else {
            return
        }

        result.append(string)
        if element.class == "ellipsis" {
            result.append("...")
        }
    }

    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        assertionFailure("\(parseError)")
    }
}

extension NSMutableAttributedString {
    fileprivate func append(_ string: String) {
        append(NSAttributedString(string: string))
    }

    fileprivate func trimCharacters(in set: CharacterSet) {
        let trimmedString = string.trimmingCharacters(in: set)
        let trimmedStringRange = (string as NSString).range(of: trimmedString)
        guard trimmedStringRange.location != NSNotFound else {
            return
        }

        let trimmedStringEndLocation = trimmedStringRange.location + trimmedStringRange.length
        deleteCharacters(in: NSRange(location: trimmedStringEndLocation, length: length - trimmedStringEndLocation))
        deleteCharacters(in: NSRange(location: 0, length: trimmedStringRange.location))
    }
}

import Foundation

public struct Pagination {
    public enum Item {
        case olderThan(String)
        case newerThan(String)
        case immediatelyNewer(String)

        var key: String {
            switch self {
            case .olderThan:
                return "max_id"
            case .newerThan:
                return "since_id"
            case .immediatelyNewer:
                return "min_id"
            }
        }

        var value: String {
            switch self {
            case .olderThan(let value),
                 .newerThan(let value),
                 .immediatelyNewer(let value):
                return value
            }
        }

        init?(_ string: String) {
            let string = String(string.dropFirst().prefix(while: { $0 != ">" }))
            guard let queryItems = URLComponents(string: string)?.queryItems else {
                return nil
            }

            for queryItem in queryItems {
                guard let value = queryItem.value else {
                    continue
                }

                switch queryItem.name {
                case "max_id":
                    self = .olderThan(value)
                    return
                case "since_id":
                    self = .newerThan(value)
                    return
                case "min_id":
                    self = .immediatelyNewer(value)
                    return
                default:
                    continue
                }
            }

            return nil
        }
    }

    public let next: Item?
    public let previous: Item?

    init(_ string: String) {
        var next: Item?
        var previous: Item?
        string.components(separatedBy: ", ").forEach {
            if $0.contains(#"rel="next""#) {
                next = Item($0)
            }
            else if $0.contains(#"rel="prev""#) {
                previous = Item($0)
            }
        }

        self.next = next
        self.previous = previous
    }
}

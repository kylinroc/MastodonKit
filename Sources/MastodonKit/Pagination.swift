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

        init?(_ string: Substring) {
            let value = String(string.drop(while: { $0 != "=" }).dropFirst().prefix(while: { $0 != ">"}))
            if string.contains("max_id") {
                self = .olderThan(value)
            }
            else if string.contains("since_id") {
                self = .newerThan(value)
            }
            else if string.contains("min_id") {
                self = .immediatelyNewer(value)
            }
            else {
                return nil
            }
        }
    }

    public let next: Item?
    public let previous: Item?

    init(_ string: String) {
        var next: Item?
        var previous: Item?
        string.split(separator: ",").forEach {
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

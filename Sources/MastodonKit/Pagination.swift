public enum Pagination<T> {
    case olderThan(T)
    case newerThan(T)
    case immediatelyNewer(T)

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
}

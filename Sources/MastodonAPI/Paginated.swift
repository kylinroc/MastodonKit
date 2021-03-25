import Foundation
import HTTPLinkHeader

public struct Paginated<Response> {
    public let nextPaginationParameter: PaginationParameter?
    public let previousPaginationParameter: PaginationParameter?
    public let response: Response

    init(links: [HTTPLinkHeader], response: Response) {
        nextPaginationParameter = links
            .first(where: { $0.parameters.contains(where: { $0.name == "rel" && $0.value == "next" }) })
            .flatMap(PaginationParameter.init)
        previousPaginationParameter = links
            .first(where: { $0.parameters.contains(where: { $0.name == "rel" && $0.value == "prev" }) })
            .flatMap(PaginationParameter.init)
        self.response = response
    }
}

public enum PaginationParameter {
    case olderThan(id: String)
    case immediatelyNewerThan(id: String)

    init?(link: HTTPLinkHeader) {
        guard let queryItems = URLComponents(string: link.uriReference)?.queryItems else {
            return nil
        }

        if let queryItem = queryItems.first(where: { $0.name == "max_id" }), let id = queryItem.value {
            self = .olderThan(id: id)
        } else if let queryItem = queryItems.first(where: { $0.name == "min_id" }), let id = queryItem.value {
            self = .immediatelyNewerThan(id: id)
        } else {
            return nil
        }
    }

    public var maxID: String? {
        switch self {
        case .olderThan(let id):
            return id
        case .immediatelyNewerThan:
            return nil
        }
    }

    public var minID: String? {
        switch self {
        case .olderThan:
            return nil
        case .immediatelyNewerThan(let id):
            return id
        }
    }
}

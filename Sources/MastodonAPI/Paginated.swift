import Foundation
import HTTPLinkHeader

public struct Paginated<Response> {
    public let maxID: String?
    public let minID: String?
    public let response: Response

    init(links: [HTTPLinkHeader], response: Response) {
        maxID = links
            .first(where: { $0.parameters.contains(where: { $0.name == "rel" && $0.value == "next" }) })
            .flatMap {
                guard let queryItem = URLComponents(string: $0.uriReference)?
                        .queryItems?
                        .first(where: { $0.name == "max_id" }) else {
                    return nil
                }

                return queryItem.value
            }
        minID = links
            .first(where: { $0.parameters.contains(where: { $0.name == "rel" && $0.value == "prev" }) })
            .flatMap {
                guard let queryItem = URLComponents(string: $0.uriReference)?
                        .queryItems?
                        .first(where: { $0.name == "min_id" }) else {
                    return nil
                }

                return queryItem.value
            }
        self.response = response
    }
}

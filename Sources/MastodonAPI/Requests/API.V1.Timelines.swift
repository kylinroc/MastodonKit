import Foundation
import HTTPLinkHeader

extension Requests.API.V1 {
    public enum Timelines {
        public static func home(pagination: HTTPLinkHeader? = nil) -> Request<Paged<[Responses.Status]>> {
            let queryItems: [URLQueryItem]?
            if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
                queryItems = urlComponents.queryItems
            } else {
                queryItems = nil
            }

            return Request(path: "/api/v1/timelines/home", httpMethod: .get(queryItems))
        }

        public static func `public`(
            isLocal: Bool = false,
            pagination: HTTPLinkHeader? = nil
        ) -> Request<Paged<[Responses.Status]>> {
            let queryItems: [URLQueryItem]?
            if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
                queryItems = urlComponents.queryItems
            } else {
                queryItems = [URLQueryItem(name: "local", value: "\(isLocal)")]
            }

            return Request(path: "/api/v1/timelines/public", httpMethod: .get(queryItems))
        }
    }
}

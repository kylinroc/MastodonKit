import Foundation

extension Requests.API {
    public enum V2 {}
}

extension Requests.API.V2 {
    public static func search(q: String) -> Request<Responses.SearchResults> {
        Request(path: "/api/v2/search", httpMethod: .get([URLQueryItem(name: "q", value: q)]))
    }
}

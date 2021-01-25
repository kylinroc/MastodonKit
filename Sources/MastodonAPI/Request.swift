import Foundation

public struct Request<Response> {
    var path: String
    var httpMethod: HTTPMethod

    func makeURL(relativeTo url: URL) -> URL? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        urlComponents.path = path
        switch httpMethod {
        case .get(let queryItems):
            urlComponents.queryItems = queryItems
        case .post:
            break
        }

        return urlComponents.url
    }

    func makeURLRequest(relativeTo url: URL, accessToken: String?) throws -> URLRequest {
        guard let url = makeURL(relativeTo: url) else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawString
        switch httpMethod {
        case .get:
            break
        case .post(let httpBody):
            urlRequest.httpBody = httpBody
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let accessToken = accessToken {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }
}

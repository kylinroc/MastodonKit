import Foundation
import HTTPLinkHeader

public struct Client {
    public var serverURL: URL
    public var accessToken: String?

    public init(serverURL: URL, accessToken: String? = nil) {
        self.serverURL = serverURL
        self.accessToken = accessToken
    }

    public func send<Response>(_ request: Request<Response>, completion: @escaping (Result<Response, Error>) -> Void) {
        do {
            URLSession.shared.dataTask(with: try makeURLRequest(request)) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }

                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

                switch response.statusCode {
                case 200:
                    completion(Result { try jsonDecoder.decode(Response.self, from: data) })
                default:
                    do {
                        let error = try jsonDecoder.decode(Responses.Error.self, from: data)
                        completion(.failure(error))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

    private func makeURLRequest<Response>(_ request: Request<Response>) throws -> URLRequest {
        guard let url = URL(string: request.path, relativeTo: serverURL) else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accessToken = accessToken {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }

    public func makeAuthorizeURL(clientID: String, scopes: [Scope], redirectURI: String) -> URL? {
        guard var urlComponents = URLComponents(url: serverURL, resolvingAgainstBaseURL: false) else {
            return nil
        }

        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "scope", value: scopes.map(\.rawValue).joined(separator: "+")),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
        ]

        return urlComponents.url
    }
}

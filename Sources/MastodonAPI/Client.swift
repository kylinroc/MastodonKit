import Foundation
import HTTPLinkHeader

public struct Client {
    public var serverURL: URL
    public var accessToken: String?

    public init(serverURL: URL, accessToken: String? = nil) {
        self.serverURL = serverURL
        self.accessToken = accessToken
    }

    public func send<Response: Decodable>(
        _ request: Request<Response>,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        do {
            send(try makeURLRequest(request), expectedResponseType: Response.self) { result in
                completion(result.map({ $0.0 }))
            }
        } catch {
            completion(.failure(error))
        }
    }

    public func send<Response: Decodable>(
        _ request: Request<Paged<Response>>,
        completion: @escaping (Result<Paged<Response>, Error>) -> Void
    ) {
        do {
            send(try makeURLRequest(request), expectedResponseType: Response.self) { result in
                completion(result.map({ Paged(links: $0.1, response: $0.0) }))
            }
        } catch {
            completion(.failure(error))
        }
    }

    private func send<Response: Decodable>(
        _ request: URLRequest,
        expectedResponseType _: Response.Type,
        completion: @escaping (Result<(Response, [HTTPLinkHeader]), Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let httpURLResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

            do {
                switch httpURLResponse.statusCode {
                case 200:
                    let response = try jsonDecoder.decode(Response.self, from: data)
                    let links: [HTTPLinkHeader]
                    if let string = httpURLResponse.allHeaderFields["Link"] as? String {
                        links = (try? HTTPLinkHeader.parse(string)) ?? []
                    } else {
                        links = []
                    }
                    completion(.success((response, links)))
                default:
                    let error = try jsonDecoder.decode(Responses.Error.self, from: data)
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
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

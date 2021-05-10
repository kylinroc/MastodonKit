import Foundation
import HTTPLinkHeader

public struct Client {
    private var serverURL: URL
    private var accessToken: String?

    public init(serverURL: URL, accessToken: String? = nil) {
        self.serverURL = serverURL
        self.accessToken = accessToken
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

    public func send<Response: Decodable>(
        _ request: Request<Response>,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        do {
            let urlRequest = try request.makeURLRequest(relativeTo: serverURL, accessToken: accessToken)
            _send(urlRequest) { completion($0.map({ $0.1 })) }
        } catch {
            completion(.failure(error))
        }
    }

    public func send<Response: Decodable>(
        _ request: Request<Paginated<Response>>,
        completion: @escaping (Result<Paginated<Response>, Error>) -> Void
    ) {
        do {
            let urlRequest = try request.makeURLRequest(relativeTo: serverURL, accessToken: accessToken)
            _send(urlRequest) { completion($0.map({ Paginated(links: $0.0, response: $0.1) })) }
        } catch {
            completion(.failure(error))
        }
    }
}

extension Client {
    static let dateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter
    }()

    static let dateFormatterWithoutFractionalSeconds: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        return dateFormatter
    }()

    private func _send<Response: Decodable>(
        _ request: URLRequest,
        completion: @escaping (Result<([HTTPLinkHeader], Response), Error>) -> Void
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
            jsonDecoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let string = try container.decode(String.self)

                if let date = Self.dateFormatter.date(from: string) {
                    return date
                } else if let date = Self.dateFormatterWithoutFractionalSeconds.date(from: string) {
                    return date
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date string does not match format expected by formatter.")
                }
            }

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
                    completion(.success((links, response)))
                default:
                    let error = try jsonDecoder.decode(Responses.Error.self, from: data)
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

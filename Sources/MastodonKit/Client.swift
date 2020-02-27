import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public final class Client {
    public let baseURL: URL
    public let token: Token?

    public init(baseURL: URL, token: Token? = nil) {
        self.baseURL = baseURL
        self.token = token
    }

    public func send<T>(request: Request<T>, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest: URLRequest
        switch request.httpMethod {
        case .get:
            var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
            urlComponents.path = request.path
            urlComponents.queryItems = request.parameters.map(URLQueryItem.init)
            urlRequest = URLRequest(url: urlComponents.url!)
        case .post:
            let url = baseURL.appendingPathComponent(request.path)
            urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = request.httpMethod.rawValue
            do {
                urlRequest.httpBody = try JSONEncoder().encode(request.parameters)
            } catch {
                completion(.failure(error))
                return
            }
        }
        if let token = token {
            urlRequest.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                fatalError()
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    fatalError()
                }

                do {
                    let value = try Client.makeJSONDecoder().decode(T.self, from: data)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            } else {
                if let data = data {
                    do {
                        let error = try Client.makeJSONDecoder().decode(MastodonURLError.self, from: data)
                        completion(.failure(error))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }

    public func authenticationURL(for application: Application) -> URL {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: application.clientID),
            URLQueryItem(name: "client_secret", value: application.clientSecret),
            URLQueryItem(name: "redirect_uri", value: application.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
        ]
        return urlComponents.url!
    }
}

extension Client {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }()

    static func makeJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}

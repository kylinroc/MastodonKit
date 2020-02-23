import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public final class Client {
    public let baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
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
}

extension Client {
    public struct Request<T: Decodable> {
        var path: String
        var httpMethod: HTTPMethod
        var parameters: [String: String]
    }
}

extension Client.Request {
    public static func createAnApplication(
        clientName: String,
        redirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
    ) -> Client.Request<Application> {
        .init(path: "/api/v1/apps", httpMethod: .post, parameters: [
            "client_name": clientName,
            "redirect_uris": redirectURI,
        ])
    }

    public static func fetchPublicTimeline(
        local: Bool = false,
        onlyMedia: Bool = false,
        limit: Int = 20
    ) -> Client.Request<[Status]> {
        .init(path: "/api/v1/timelines/public", httpMethod: .get, parameters: [
            "local": "\(local)",
            "only_media": "\(onlyMedia)",
            "limit": "\(limit)",
        ])
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

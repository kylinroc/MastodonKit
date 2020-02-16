import Foundation

extension Mastodon {
    public struct Client {
        public let baseURL: URL

        public init(serverURL: URL) {
            self.baseURL = serverURL
                .appendingPathComponent("api")
                .appendingPathComponent("v1")
        }

        public func send<Value>(_ request: Request<Value>, completionHandler: @escaping (Result<Value, Error>) -> Void) {
            let url = baseURL.appendingPathComponent(request.path)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                urlRequest.httpBody = try JSONEncoder().encode(request.parameters)
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        completionHandler(.failure(error))
                        return
                    }

                    guard let data = data else {
                        return
                    }

                    do {
                        let value = try JSONDecoder().decode(Value.self, from: data)
                        completionHandler(.success(value))
                    } catch {
                        completionHandler(.failure(error))
                    }
                }.resume()
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}

extension Mastodon.Client {
    public struct Request<Value: Decodable> {
        public var method: String
        public var path: String
        public var parameters: [String: String]
    }
}

extension Mastodon {
    public struct Application: Codable {
        /// The name of your application.
        ///
        /// Added in 0.9.9
        public var name: String

        /// The website associated with your application.
        ///
        /// Added in 0.9.9
        public var website: URL?

        /// Client ID key, to be used for obtaining OAuth tokens.
        ///
        /// Added in 0.9.9
        public var clientID: String

        /// Client secret key, to be used for obtaining OAuth tokens.
        ///
        /// Added in 0.9.9
        public var clientSecret: String

        /// Used for Push Streaming API.
        ///
        /// Added in 2.8.0
        public var vapidKey: String?

        private enum CodingKeys: String, CodingKey {
            case name
            case website
            case clientID = "client_id"
            case clientSecret = "client_secret"
            case vapidKey = "vapid_key"
        }
    }
}

extension Mastodon.Application {
    public static func create(
        clientName: String,
        redirectURIs: String = "urn:ietf:wg:oauth:2.0:oob"
    ) -> Mastodon.Client.Request<Mastodon.Application> {
        return Mastodon.Client.Request(method: "POST", path: "apps", parameters: [
            "client_name": clientName,
            "redirect_uris": redirectURIs,
        ])
    }
}

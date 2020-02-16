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

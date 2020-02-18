import Foundation

public final class Client {
    public let baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    public func send<T>(request: Request<T>, completion: @escaping (Result<T, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request.parameters)

            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}

extension Client {
    public struct Request<T: Decodable> {
        var path: String
        var method: String
        var parameters: [String: String]
    }
}

extension Client.Request {
    public static func createAnApplication(
        clientName: String,
        redirectURIs: String = "urn:ietf:wg:oauth:2.0:oob"
    ) -> Client.Request<Application> {
        .init(path: "/api/v1/apps", method: "POST", parameters: [
            "client_name": clientName,
            "redirect_uris": redirectURIs,
        ])
    }
}

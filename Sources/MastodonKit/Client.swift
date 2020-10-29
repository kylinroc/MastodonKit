import Foundation

public enum Scope: String, Encodable {
    case read
    case write
    case follow
    case push
}

public struct Client {
    private let serverURL: URL

    public init(serverURL: URL) {
        self.serverURL = serverURL
    }

    public func createApplication(
        name: String,
        redirectURIs: [String] = ["urn:ietf:wg:oauth:2.0:oob"],
        scopes: [Scope] = [.read],
        website: String? = nil,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        struct Parameters: Encodable {
            private enum CodingKeys: String, CodingKey {
                case name = "client_name"
                case redirectURIs = "redirect_uris"
                case scopes
                case website
            }

            let name: String
            let redirectURIs: [String]
            let scopes: [Scope]
            let website: String?
        }

        let url = URL(string: "/api/v1/apps", relativeTo: serverURL)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = try? JSONEncoder().encode(Parameters(
            name: name,
            redirectURIs: redirectURIs,
            scopes: scopes,
            website: website
        ))
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            let response = response as! HTTPURLResponse
            switch response.statusCode {
            case 200:
                completion(.success(()))
            default:
                print(response)
            }
        }.resume()
    }
}

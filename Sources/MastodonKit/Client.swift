import Foundation

public struct Client {
    private let serverURL: URL
    private let session: URLSession

    public init(serverURL: URL, session: URLSession = .shared) {
        self.serverURL = serverURL
        self.session = session
    }

    public func createApplication(
        name: String,
        redirectURI: String = "urn:ietf:wg:oauth:2.0:oob",
        scopes: [Scope] = [.read],
        website: String? = nil,
        completion: @escaping (Result<Responses.Application, Error>) -> Void
    ) {
        struct Parameters: Encodable {
            private enum CodingKeys: String, CodingKey {
                case name = "client_name"
                case redirectURI = "redirect_uris"
                case scopes
                case website
            }

            let name: String
            let redirectURI: String
            let scopes: [Scope]
            let website: String?
        }

        let url = URL(string: "/api/v1/apps", relativeTo: serverURL)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = try? JSONEncoder().encode(Parameters(
            name: name,
            redirectURI: redirectURI,
            scopes: scopes,
            website: website
        ))
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            completion(Result {
                try JSONDecoder().decode(Responses.Application.self, from: data)
            })
        }.resume()
    }
}

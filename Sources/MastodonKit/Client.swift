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
            let scopes: String
            let website: String?
        }

        let url = URL(string: "/api/v1/apps", relativeTo: serverURL)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = try? JSONEncoder().encode(Parameters(
            name: name,
            redirectURI: redirectURI,
            scopes: scopes.map(\.rawValue).joined(separator: " "),
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

    public func obtainToken(
        clientID: String,
        clientSecret: String,
        redirectURI: String,
        scopes: [Scope] = [.read],
        completion: @escaping (Result<Responses.Token, Error>) -> Void
    ) {
        struct Parameters: Encodable {
            private enum CodingKeys: String, CodingKey {
                case clientID = "client_id"
                case clientSecret = "client_secret"
                case redirectURI = "redirect_uri"
                case scope
                case grantType = "grant_type"
            }

            let clientID: String
            let clientSecret: String
            let redirectURI: String
            let scope: String
            let grantType = "client_credentials"
        }

        guard let url = URL(string: "/oauth/token", relativeTo: serverURL) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpBody = try? JSONEncoder().encode(Parameters(
            clientID: clientID,
            clientSecret: clientSecret,
            redirectURI: redirectURI,
            scope: scopes.map(\.rawValue).joined(separator: " ")
        ))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            completion(Result {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                return try decoder.decode(Responses.Token.self, from: data)
            })
        }.resume()
    }
}

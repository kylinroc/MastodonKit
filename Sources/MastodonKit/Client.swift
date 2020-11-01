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

        do {
            let parameters = Parameters(
                name: name,
                redirectURI: redirectURI,
                scopes: scopes.map(\.rawValue).joined(separator: " "),
                website: website
            )
            let data = try JSONEncoder().encode(parameters)
            let request = Request(path: "/api/v1/apps", httpBody: data, httpMethod: .post)
            session.dataTask(with: try makeURLRequest(request)) { data, response, error in
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
        } catch {
            completion(.failure(error))
        }
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

        do {
            let parameters = Parameters(
                clientID: clientID,
                clientSecret: clientSecret,
                redirectURI: redirectURI,
                scope: scopes.map(\.rawValue).joined(separator: " ")
            )
            let httpBody = try JSONEncoder().encode(parameters)
            let request = Request(path: "/oauth/token", httpBody: httpBody, httpMethod: .post)
            let urlRequest = try makeURLRequest(request)
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
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    return try decoder.decode(Responses.Token.self, from: data)
                })
            }.resume()
        } catch {
            completion(.failure(error))
            return
        }
    }

    private func makeURLRequest(_ request: Request) throws -> URLRequest {
        guard let url = URL(string: request.path, relativeTo: serverURL) else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = request.httpBody
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}

import Foundation

public struct Client {
    private let serverURL: URL
    private let session: URLSession

    public init(serverURL: URL, session: URLSession = .shared) {
        self.serverURL = serverURL
        self.session = session
    }

    public func send<Response>(_ request: Request<Response>, completion: @escaping (Result<Response, Error>) -> Void) {
        do {
            session.dataTask(with: try makeURLRequest(request)) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }

                switch response.statusCode {
                case 200:
                    completion(Result { try JSONDecoder().decode(Response.self, from: data) })
                default:
                    do {
                        let error = try JSONDecoder().decode(Responses.Error.self, from: data)
                        completion(.failure(error))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

    private func makeURLRequest<Response>(_ request: Request<Response>) throws -> URLRequest {
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

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public struct Request<Reponse: Decodable> {
    let path: String
    let httpMethod: HTTPMethod
    let parameters: [String: String]
}

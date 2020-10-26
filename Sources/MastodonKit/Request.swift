protocol RequestProtocol {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String]? { get }
}

public struct Request<Reponse: Decodable>: RequestProtocol {
    let path: String
    let httpMethod: HTTPMethod
    let parameters: [String: String]?
}

public struct PageableRequest<Response: Decodable>: RequestProtocol {
    let path: String
    let httpMethod: HTTPMethod
    let parameters: [String: String]?
}

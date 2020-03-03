public struct Request<Reponse: Decodable> {
    let path: String
    let httpMethod: HTTPMethod
    let parameters: [String: String]?
}

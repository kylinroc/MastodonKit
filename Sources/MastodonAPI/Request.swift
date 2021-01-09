import Foundation

public struct Request<Response: Decodable> {
    var path: String
    var httpMethod: HTTPMethod
    var httpBody: Data?
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy?
}

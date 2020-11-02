import Foundation

public struct Request<Response: Decodable> {
    let path: String
    let httpMethod: HTTPMethod
    let httpBody: Data?
}

import Foundation

public struct Request<Response: Decodable> {
    let path: String
    let httpBody: Data?
    let httpMethod: HTTPMethod
}

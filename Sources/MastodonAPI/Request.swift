import Foundation

public struct Request<Response> {
    var path: String
    var httpMethod: HTTPMethod
    var httpBody: Data?
}

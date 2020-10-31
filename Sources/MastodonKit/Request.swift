import Foundation

struct Request {
    let path: String
    let httpBody: Data?
    let httpMethod: HTTPMethod
}

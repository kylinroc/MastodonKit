import Foundation

enum HTTPMethod {
    static var get: HTTPMethod { .get(nil) }
    static var post: HTTPMethod { .post(nil) }

    case get([URLQueryItem]?)
    case post(Data?)

    var rawString: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

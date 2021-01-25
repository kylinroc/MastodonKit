import Foundation

enum HTTPMethod {
    case get([URLQueryItem]?)
    case post(Data?)

    var rawString: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

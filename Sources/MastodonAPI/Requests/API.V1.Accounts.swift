import Foundation

extension Requests.API.V1 {
    public enum Accounts {}
}

extension Requests.API.V1.Accounts {
    public static func relationships(ids: [String]) -> Request<[Responses.Relationship]> {
        Request(path: "/api/v1/accounts/relationships", httpMethod: .get(ids.map {
            URLQueryItem(name: "id[]", value: $0)
        }))
    }

    public static func verifyCredentials() -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/verify_credentials", httpMethod: .get(nil))
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public struct Request<T: Decodable> {
    var path: String
    var httpMethod: HTTPMethod
    var parameters: [String: String]
}

extension Request {
    public static func createAnApplication(
        clientName: String,
        redirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
    ) -> Request<Application> {
        .init(path: "/api/v1/apps", httpMethod: .post, parameters: [
            "client_name": clientName,
            "redirect_uris": redirectURI,
        ])
    }

    public static func fetchPublicTimeline(
        local: Bool = false,
        onlyMedia: Bool = false,
        limit: Int = 20
    ) -> Request<[Status]> {
        .init(path: "/api/v1/timelines/public", httpMethod: .get, parameters: [
            "local": "\(local)",
            "only_media": "\(onlyMedia)",
            "limit": "\(limit)",
        ])
    }

    public static func fetchHomeTimeline() -> Request<[Status]> {
        .init(path: "/api/v1/timelines/home", httpMethod: .get, parameters: [:])
    }

    public static func obtainToken(for application: Application, authorizationCode: String) -> Request<Token> {
        .init(path: "/oauth/token", httpMethod: .post, parameters: [
            "client_id": application.clientID!,
            "client_secret": application.clientSecret!,
            "redirect_uri": application.redirectURI!,
            "code": authorizationCode,
            "grant_type": "authorization_code",
        ])
    }
}

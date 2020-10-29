public enum Requests {
    public static func verifyCredentials() -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/verify_credentials", httpMethod: .get, parameters: nil)
    }

    public static func account(id: String) -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/\(id)", httpMethod: .get, parameters: nil)
    }

    public static func favorites(pagination: Pagination.Item? = nil) -> PageableRequest<[Responses.Toot]> {
        var parameters: [String: String]? = [:]
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        }
        return PageableRequest(path: "/api/v1/favourites", httpMethod: .get, parameters: parameters)
    }

    public static func obtainToken(
        application: Responses.Application,
        authorizationCode: String,
        scopes: [Scope]
    ) -> Request<Responses.Token> {
        Request(path: "/oauth/token", httpMethod: .post, parameters: [
            "client_id": application.clientID!,
            "client_secret": application.clientSecret!,
            "redirect_uri": application.redirectURI!,
            "scope": scopes.map(\.rawValue).joined(separator: " "),
            "code": authorizationCode,
            "grant_type": "authorization_code",
        ])
    }

    public static func bookmark(toot: Responses.Toot) -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(toot.id)/bookmark", httpMethod: .post, parameters: nil)
    }

    public static func context(of toot: Responses.Toot) -> Request<Responses.Context> {
        Request(path: "/api/v1/statuses/\(toot.id)/context", httpMethod: .get, parameters: nil)
    }

    public static func unbookmark(toot: Responses.Toot) -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(toot.id)/unbookmark", httpMethod: .post, parameters: nil)
    }

    public static func unfavorite(toot: Responses.Toot) -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(toot.id)/unfavourite", httpMethod: .post, parameters: nil)
    }

    public static func boost(toot: Responses.Toot) -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(toot.id)/reblog", httpMethod: .post, parameters: nil)
    }

    public static func unboost(toot: Responses.Toot) -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(toot.id)/unreblog", httpMethod: .post, parameters: nil)
    }

    public static func favorite(toot: Responses.Toot) -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(toot.id)/favourite", httpMethod: .post, parameters: nil)
    }

    public static func bookmarks(pagination: Pagination.Item? = nil) -> PageableRequest<[Responses.Toot]> {
        var parameters: [String: String]? = [:]
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        }
        return PageableRequest(path: "/api/v1/bookmarks", httpMethod: .get, parameters: parameters)
    }

    public static func relationship(with account: Responses.Account) -> Request<[Responses.Relationship]> {
        Request(path: "/api/v1/accounts/relationships", httpMethod: .get, parameters: ["id": "\(account.id)"])
    }

    public static func unfollow(_ account: Responses.Account) -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(account.id)/unfollow", httpMethod: .post, parameters: nil)
    }

    public static func unblock(_ account: Responses.Account) -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(account.id)/unblock", httpMethod: .post, parameters: nil)
    }

    public static func block(_ account: Responses.Account) -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(account.id)/block", httpMethod: .post, parameters: nil)
    }

    public static func unmute(_ account: Responses.Account) -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(account.id)/unmute", httpMethod: .post, parameters: nil)
    }

    public static func mute(_ account: Responses.Account) -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(account.id)/mute", httpMethod: .post, parameters: nil)
    }

    public static func createApplication(
        name: String,
        redirectURI: String = "urn:ietf:wg:oauth:2.0:oob",
        scopes: [Scope] = [.read]
    ) -> Request<Responses.Application> {
        Request(path: "/api/v1/apps", httpMethod: .post, parameters: [
            "client_name": name,
            "redirect_uris": redirectURI,
            "scopes": scopes.map(\.rawValue).joined(separator: " "),
        ])
    }
}

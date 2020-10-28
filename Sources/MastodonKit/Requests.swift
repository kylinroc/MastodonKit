public enum Requests {
    public static func verifyCredentials() -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/verify_credentials", httpMethod: .get, parameters: nil)
    }

    public static func account(id: String) -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/\(id)", httpMethod: .get, parameters: nil)
    }

    public static func followers(
        of account: Responses.Account,
        pagination: Pagination.Item? = nil
    ) -> PageableRequest<[Responses.Account]> {
        let parameters: [String: String]?
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        } else {
            parameters = nil
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(account.id)/followers",
            httpMethod: .get,
            parameters: parameters
        )
    }

    public static func following(
        of account: Responses.Account,
        pagination: Pagination.Item? = nil
    ) -> PageableRequest<[Responses.Account]> {
        let parameters: [String: String]?
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        } else {
            parameters = nil
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(account.id)/following",
            httpMethod: .get,
            parameters: parameters
        )
    }

    public static func pinnedToots(of account: Responses.Account) -> Request<[Responses.Toot]> {
        Request(path: "/api/v1/accounts/\(account.id)/statuses", httpMethod: .get, parameters: ["pinned": "true"])
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
}

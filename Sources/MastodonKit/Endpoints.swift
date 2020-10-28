public enum Endpoints {
    public static func bookmarks(pagination: Pagination.Item? = nil) -> PageableRequest<[Responses.Toot]> {
        var parameters: [String: String]? = [:]
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        }
        return PageableRequest(path: "/api/v1/bookmarks", httpMethod: .get, parameters: parameters)
    }

    public static func toots(
        of account: Responses.Account,
        excludeReplies: Bool,
        onlyMedia: Bool = false,
        pagination: Pagination.Item? = nil
    ) -> PageableRequest<[Responses.Toot]> {
        var parameters = [
            "exclude_replies": "\(excludeReplies)",
            "only_media": "\(onlyMedia)",
        ]
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(account.id)/statuses",
            httpMethod: .get,
            parameters: parameters
        )
    }

    public static func relationship(with account: Responses.Account) -> Request<[Responses.Relationship]> {
        Request(path: "/api/v1/accounts/relationships", httpMethod: .get, parameters: ["id": "\(account.id)"])
    }

    public static func follow(_ account: Responses.Account) -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(account.id)/follow", httpMethod: .post, parameters: nil)
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

extension Endpoints {
    public enum Timelines {
        public static func home(pagination: Pagination.Item? = nil) -> PageableRequest<[Responses.Toot]> {
            var parameters: [String: String]?
            if let pagination = pagination {
                parameters = [pagination.key: pagination.value]
            }
            return PageableRequest(path: "/api/v1/timelines/home", httpMethod: .get, parameters: parameters)
        }

        public static func `public`(
            local: Bool = false,
            pagination: Pagination.Item? = nil
        ) -> PageableRequest<[Responses.Toot]> {
            var parameters: [String: String] = [
                "local": "\(local)",
            ]
            if let pagination = pagination {
                parameters[pagination.key] = pagination.value
            }
            return PageableRequest(path: "/api/v1/timelines/public", httpMethod: .get, parameters: parameters)
        }

        public static func tag(
            _ tag: Responses.Tag,
            pagination: Pagination.Item? = nil
        ) -> PageableRequest<[Responses.Toot]> {
            var parameters: [String: String]?
            if let pagination = pagination {
                parameters = [pagination.key: pagination.value]
            }
            return PageableRequest(path: "/api/v1/timelines/tag/\(tag.name)", httpMethod: .get, parameters: parameters)
        }
    }
}

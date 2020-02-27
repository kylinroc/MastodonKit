public enum Timeline {
    public static func home() -> Request<[Status]> {
        Request(path: "/api/v1/timelines/home", httpMethod: .get, parameters: [:])
    }

    public static func `public`(
        local: Bool = false,
        onlyMedia: Bool = false,
        limit: Int = 20
    ) -> Request<[Status]> {
        Request(path: "/api/v1/timelines/public", httpMethod: .get, parameters: [
            "local": "\(local)",
            "only_media": "\(onlyMedia)",
            "limit": "\(limit)",
        ])
    }
}

extension Requests.API.V1 {
    public struct Statuses {
        private let id: String

        public init(_ id: String) {
            self.id = id
        }

        public func reblog() -> Request<Responses.Toot> {
            Request(path: "/api/v1/statuses/\(id)/reblog", httpMethod: .post(nil))
        }

        public func unreblog() -> Request<Responses.Toot> {
            Request(path: "/api/v1/statuses/\(id)/unreblog", httpMethod: .post(nil))
        }

        public func favourite() -> Request<Responses.Toot> {
            Request(path: "/api/v1/statuses/\(id)/favourite", httpMethod: .post(nil))
        }

        public func unfavourite() -> Request<Responses.Toot> {
            Request(path: "/api/v1/statuses/\(id)/unfavourite", httpMethod: .post(nil))
        }

        public func bookmark() -> Request<Responses.Toot> {
            Request(path: "/api/v1/statuses/\(id)/bookmark", httpMethod: .post(nil))
        }

        public func unbookmark() -> Request<Responses.Toot> {
            Request(path: "/api/v1/statuses/\(id)/unbookmark", httpMethod: .post(nil))
        }
    }
}

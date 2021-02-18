extension Requests.API.V1 {
    public struct Statuses {
        private let id: String

        public init(_ id: String) {
            self.id = id
        }

        public func favourite() -> Request<Responses.Toot> {
            Request(path: "/api/v1/statuses/\(id)/favourite", httpMethod: .post(nil))
        }
    }
}

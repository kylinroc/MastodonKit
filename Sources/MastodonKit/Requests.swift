public enum Requests {}

extension Requests {
    public enum Accounts {
        public static var verifyCredentials: Request<Responses.Account> {
            Request(path: "/api/v1/accounts/verify_credentials", httpMethod: .get, parameters: nil)
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
    }
}

extension Requests.API.V1 {
    public enum Accounts {
        public static func verifyCredentials() -> Request<Responses.Account> {
            Request(path: "/api/v1/accounts/verify_credentials", httpMethod: .get(nil))
        }
    }
}

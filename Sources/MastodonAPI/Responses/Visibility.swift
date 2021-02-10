extension Responses {
    public enum Visibility: String, Decodable {
        case `public`
        case unlisted
        case `private`
        case direct
    }
}

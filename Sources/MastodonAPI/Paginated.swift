import HTTPLinkHeader

public struct Paginated<Response> {
    public let nextLink: HTTPLinkHeader?
    public let previousLink: HTTPLinkHeader?
    public let response: Response
}

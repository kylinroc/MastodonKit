import HTTPLinkHeader

public struct Paginated<Response> {
    public let links: [HTTPLinkHeader]
    public let response: Response
}

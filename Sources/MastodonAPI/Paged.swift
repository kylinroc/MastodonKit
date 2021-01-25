import HTTPLinkHeader

public struct Paged<Response> {
    public let links: [HTTPLinkHeader]
    public let response: Response
}

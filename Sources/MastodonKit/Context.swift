/// Represents the tree around a given toot. Used for reconstructing threads of toots.
public struct Context: Decodable {
    /// Parents in the thread.
    ///
    /// Added in 0.6.0
    public let ancestors: [Responses.Toot]

    /// Children in the thread.
    ///
    /// Added in 0.6.0
    public let descendants: [Responses.Toot]
}

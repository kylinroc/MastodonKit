import Foundation

/// Represents the last read position within a user's timelines.
public struct Markers: Codable {
    public struct Marker: Codable {
        private enum CodingKeys: String, CodingKey {
            case lastReadID = "last_read_id"
            case updatedAt = "updated_at"
            case version
        }

        /// The ID of the most recently viewed entity.
        ///
        /// Added in 3.0.0
        let lastReadID: String

        /// The timestamp of when the marker was set.
        ///
        /// Added in 3.0.0
        let updatedAt: Date

        /// Used for locking to prevent write conflicts.
        ///
        /// Added in 3.0.0
        let version: Int
    }

    /// Information about the user's position in the home timeline.
    ///
    /// Added in 3.0.0
    let home: Marker

    /// Information about the user's position in their notifications.
    ///
    /// Added in 3.0.0
    let notification: Marker
}

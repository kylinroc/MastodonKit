public enum Responses {}

protocol ResponseWithPage {}

extension Array: ResponseWithPage where Element == Responses.Toot {}

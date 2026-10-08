import Foundation

public struct Wallpaper: Identifiable, Hashable, Sendable {
    public let id: UUID
    public var title: String
    public var author: String
    public var imageURL: URL?

    public init(id: UUID = UUID(), title: String, author: String, imageURL: URL? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.imageURL = imageURL
    }
}

public extension Wallpaper {
    static let sample: [Wallpaper] = [
        Wallpaper(title: "Mountain Sunrise", author: "Ansel A."),
        Wallpaper(title: "Ocean Drift", author: "Marina B."),
        Wallpaper(title: "Neon City", author: "Cyra C."),
    ]
}

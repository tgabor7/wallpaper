import XCTest
@testable import WallpaperKit

final class WallpaperTests: XCTestCase {
    func testSampleWallpapersAreNotEqual() {
        let ids = Set(Wallpaper.sample.map(\.id))
        XCTAssertEqual(ids.count, Wallpaper.sample.count)
    }

    func testWallpaperHashableForNavigation() {
        let wallpaper = Wallpaper(title: "A", author: "B")
        var set = Set<Wallpaper>()
        set.insert(wallpaper)
        set.insert(wallpaper)
        XCTAssertEqual(set.count, 1)
    }
}

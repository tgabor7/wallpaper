import SwiftUI

public struct ContentView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                Section("Wallpapers") {
                    ForEach(Wallpaper.sample) { wallpaper in
                        NavigationLink(value: wallpaper) {
                            WallpaperRow(wallpaper: wallpaper)
                        }
                    }
                }
            }
            .navigationTitle("Wallpaper")
            .navigationDestination(for: Wallpaper.self) { wallpaper in
                WallpaperDetailView(wallpaper: wallpaper)
            }
        }
    }
}

#Preview {
    ContentView()
}

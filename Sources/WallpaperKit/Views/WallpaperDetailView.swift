import SwiftUI

struct WallpaperDetailView: View {
    let wallpaper: Wallpaper

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                placeholder
                Text(wallpaper.title)
                    .font(.title.bold())
                Text("by \(wallpaper.author)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle(wallpaper.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.quaternary)
            .aspectRatio(9 / 16, contentMode: .fit)
            .overlay {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
    }
}

#Preview {
    NavigationStack {
        WallpaperDetailView(wallpaper: Wallpaper.sample[0])
    }
}

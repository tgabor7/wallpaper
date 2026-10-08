import SwiftUI

struct WallpaperRow: View {
    let wallpaper: Wallpaper

    var body: some View {
        HStack(spacing: 12) {
            thumbnail
            VStack(alignment: .leading, spacing: 4) {
                Text(wallpaper.title)
                    .font(.headline)
                Text(wallpaper.author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    private var thumbnail: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.quaternary)
            .frame(width: 56, height: 56)
            .overlay {
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
            }
    }
}

#Preview {
    List {
        WallpaperRow(wallpaper: Wallpaper.sample[0])
    }
}

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "star.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.yellow)
                Text("Favorites")
                    .font(.title2).bold()
                Text("Your saved properties will appear here.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Favorites")
        }
    }
}

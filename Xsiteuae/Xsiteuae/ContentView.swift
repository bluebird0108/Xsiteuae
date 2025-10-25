import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // 🏠 Home / Properties Tab
            PropertyListView()
                .tabItem {
                    Label("Properties", systemImage: "building.2.fill")
                }

            // 👷 Developers Tab
            DeveloperListView()
                .tabItem {
                    Label("Developers", systemImage: "person.3.fill")
                }

            // 🧑‍💼 About Us Tab
            AboutUsView()
                .tabItem {
                    Label("About", systemImage: "info.circle.fill")
                }
        }
        .accentColor(.black) // or .white depending on theme
        .background(Color(.systemBackground))
    }
}

#Preview {
    ContentView()
}

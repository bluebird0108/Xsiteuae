import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // 🏠 Home
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            // 🏗 Properties
            PropertyListView()
                .tabItem {
                    Image(systemName: "building.2.fill")
                    Text("Properties")
                }

            // 👥 Meet Our Team
            TeamView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Team")
                }

            // 🧠 AI Assistant
            AIAssistantView()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("AI")
                }

            // 🔐 Login
            LoginView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Login")
                }
        }
        .tint(.yellow)
    }
}

// Temporary placeholder so the file compiles.
// Replace with your real implementation when ready.
private struct TeamView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "person.3.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.yellow)
                Text("Our Team")
                    .font(.title2).bold()
                Text("Team details coming soon.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Team")
        }
    }
    
}

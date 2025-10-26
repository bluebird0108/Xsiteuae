import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ZStack {
            // Background animation
            AnimatedGradientBackground()

            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)

                ReadyPropertiesView()
                    .tabItem {
                        Label("Ready", systemImage: "building.2.fill")
                    }
                    .tag(1)

                OffPlanProjectsView()
                    .tabItem {
                        Label("Off-Plan", systemImage: "city.fill")
                    }
                    .tag(2)

                LeasingView()
                    .tabItem {
                        Label("Leasing", systemImage: "key.fill")
                    }
                    .tag(3)

                MortgageCalculatorView()
                    .tabItem {
                        Label("Mortgage", systemImage: "dollarsign.circle.fill")
                    }
                    .tag(4)

                AboutUsView()
                    .tabItem {
                        Label("About Us", systemImage: "info.circle.fill")
                    }
                    .tag(5)
            }
            .accentColor(Theme.goldAccent)
        }
    }
}
TabView(selection: $selectedTab) {
    NavigationStack { HomeView() }
        .tabItem { Label("Home", systemImage: "house.fill") }
        .tag(0)

    NavigationStack { ReadyPropertiesView() }
        .tabItem { Label("Ready", systemImage: "building.2.fill") }
        .tag(1)

    NavigationStack { OffPlanProjectsView() }
        .tabItem { Label("Off-Plan", systemImage: "city.fill") }
        .tag(2)

    NavigationStack { LeasingView() }
        .tabItem { Label("Leasing", systemImage: "key.fill") }
        .tag(3)

    NavigationStack { MortgageCalculatorView() }
        .tabItem { Label("Mortgage", systemImage: "dollarsign.circle.fill") }
        .tag(4)

    NavigationStack { AboutUsView() }
        .tabItem { Label("About Us", systemImage: "info.circle.fill") }
        .tag(5)
}

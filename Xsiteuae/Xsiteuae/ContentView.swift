import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack { HomeView() }
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)

            NavigationStack { ReadyProjectsView() }
                .tabItem { Label("Ready", systemImage: "building.2.fill") }
                .tag(1)

            NavigationStack { OffPlanProjectsView() }
                .tabItem { Label("Off-Plan", systemImage: "building.columns.fill") }
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
        .accentColor(.white)
    }
}

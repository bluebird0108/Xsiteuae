import SwiftUI

struct DevelopersView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Featured Developers")) {
                    Label("Emaar", systemImage: "building.2.fill")
                    Label("DAMAC", systemImage: "building.2.fill")
                    Label("Nakheel", systemImage: "building.2.fill")
                    Label("Meraas", systemImage: "building.2.fill")
                }
            }
            .navigationTitle("Developers")
        }
    }
}

#Preview {
    DevelopersView()
}

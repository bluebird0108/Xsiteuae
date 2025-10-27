import SwiftUI

struct BranchesView: View {
    var body: some View {
        List {
            Section(header: Text("Main Office")) {
                Label("Xsite Real Estate Brokers LLC", systemImage: "building.2")
                Text("Dubai, United Arab Emirates")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Link("Open in Maps", destination: URL(string: "https://maps.apple.com/?q=Xsite+Real+Estate+Dubai")!)
            }

            Section(header: Text("Branch Office")) {
                Label("Xsite Real Estate – Sharjah", systemImage: "building")
                Text("Sharjah, United Arab Emirates")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Link("Open in Maps", destination: URL(string: "https://maps.apple.com/?q=Xsite+Real+Estate+Sharjah")!)
            }
        }
        .navigationTitle("Our Branches")
        .listStyle(InsetGroupedListStyle())
    }
}

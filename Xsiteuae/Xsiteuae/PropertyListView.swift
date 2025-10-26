import SwiftUI

struct PropertyListView: View {
    @StateObject private var viewModel = PropertyService()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Properties")
        }
        .onAppear {
            if self.viewModel.listings.isEmpty && !self.viewModel.isLoading {
                // Call the object, not the projected binding
                self.viewModel.fetchXsiteProperties()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if self.viewModel.isLoading {
            VStack(spacing: 12) {
                ProgressView()
                Text("Loading properties...")
                    .foregroundColor(.secondary)
            }
        } else if let error = self.viewModel.errorMessage, self.viewModel.listings.isEmpty {
            VStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.orange)
                Text("Couldn’t load properties")
                    .font(.headline)
                Text(error)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Button("Retry") {
                    self.viewModel.fetchXsiteProperties()
                }
            }
            .padding()
        } else {
            List {
                ForEach(self.viewModel.listings) { property in
                    NavigationLink(
                        destination: PropertyDetailView(property: property)
                    ) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(property.title)
                                .font(.headline)
                            Text(property.location)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    PropertyListView()
}

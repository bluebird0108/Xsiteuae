import SwiftUI

struct PropertyListView: View {
    @StateObject private var service = PropertyService()

    var body: some View {
        NavigationStack {
            Group {
                if service.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                        Text("Loading properties...")
                            .foregroundColor(.secondary)
                    }
                } else if let error = service.errorMessage, service.listings.isEmpty {
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
                            service.fetchXsiteProperties()
                        }
                    }
                    .padding()
                } else {
                    List(service.listings) { property in
                        NavigationLink {
                            PropertyDetailView(property: property)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(property.title)
                                    .font(.headline)
                                Text(property.location)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Properties")
        }
        .task {
            service.fetchXsiteProperties()
        }
    }
}

#Preview {
    PropertyListView()
}

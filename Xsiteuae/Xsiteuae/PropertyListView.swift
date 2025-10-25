import SwiftUI

struct PropertyListView: View {
    @StateObject private var finder = PropertyFinderService()

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                if finder.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Text("Loading properties...")
                            .foregroundColor(.secondary)
                    }
                } else if let error = finder.errorMessage, finder.listings.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                            .font(.system(size: 40))
                        Text("Couldn’t load live data")
                            .font(.headline)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            Task { await finder.fetchProperties() }
                        }
                        .buttonStyleNeutral()
                        .padding(.top, 6)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(finder.listings) { property in
                                NavigationLink(destination: PropertyDetailView(property: property)) {
                                    PropertyCard(property: property)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Properties")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await finder.fetchProperties()
        }
    }
}

#Preview {
    PropertyListView()
}

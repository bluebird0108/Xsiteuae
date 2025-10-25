import SwiftUI

struct PropertyListView: View {
    @StateObject private var apiService = XsiteAPIService()
    @State private var isLoading = true
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            ZStack {
                // Background color adaptive
                Color(.systemBackground)
                    .ignoresSafeArea()

                if isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                        Text("Loading properties...")
                            .foregroundColor(.secondary)
                    }
                } else if let errorMessage = errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 40))
                        Text("Error loading properties")
                            .font(.headline)
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            fetchProperties()
                        }
                        .buttonStyleNeutral()
                        .padding(.top, 6)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(apiService.properties) { property in
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
        .onAppear {
            fetchProperties()
        }
    }

    // MARK: - Fetch from API
    private func fetchProperties() {
        isLoading = true
        errorMessage = nil

        apiService.fetchProperties { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let properties):
                    apiService.properties = properties
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    PropertyListView()
}

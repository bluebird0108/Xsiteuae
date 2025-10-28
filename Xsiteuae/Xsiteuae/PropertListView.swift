import SwiftUI

struct PropertyListView: View {
    @StateObject private var service = PropertyFinderService() // ✅ Corrected service
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            Group {
                if service.isLoading {
                    ProgressView("Loading properties…")
                        .tint(.yellow)
                        .padding()
                } else if let error = service.errorMessage {
                    VStack(spacing: 12) {
                        Text("⚠️ \(error)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task { await service.fetchProperties() }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.yellow)
                    }
                } else {
                    List(service.listings) { property in
                        NavigationLink(destination: PropertyDetailView(property: property)) {
                            PropertyCard(property: property)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("🏙 Properties")
            .task {
                await service.fetchProperties()
            }
        }
    }
}

struct PropertyCard: View {
    let property: Property

    private var priceText: String {
        property.price > 0 ? "AED \(Int(property.price))" : "AED —"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: property.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 3)

            VStack(alignment: .leading, spacing: 4) {
                Text(property.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(priceText)
                    .font(.subheadline)
                    .foregroundColor(.yellow)
                    .fontWeight(.semibold)

                Text(property.location)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    PropertyListView()
}

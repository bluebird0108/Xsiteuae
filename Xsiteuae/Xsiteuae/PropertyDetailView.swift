import SwiftUI

struct PropertyDetailView: View {
    let property: Property

    // 💰 Format price display
    private var priceText: String {
        let value = property.price
        return value > 0 ? "AED \(Int(value))" : "AED —"
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    // 🖼 Property Image
                    AsyncImage(url: URL(string: property.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8)

                    // 🏷 Title
                    Text(property.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 4)

                    // 💰 Price
                    Text(priceText)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.yellow)

                    // 📍 Location
                    Text(property.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Divider().padding(.vertical, 8)

                    // 🧱 Developer Info
                    HStack(spacing: 10) {
                        if let logo = property.developerLogo,
                           let url = URL(string: logo) {
                            AsyncImage(url: url) { img in
                                img.resizable().scaledToFit()
                            } placeholder: {
                                Color.gray.opacity(0.2)
                            }
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(property.developerName ?? "Developer")
                                .font(.headline)
                            Text("Project by leading UAE developer")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Divider().padding(.vertical, 8)

                    // 📐 Property Details
                    VStack(alignment: .leading, spacing: 8) {
                        if let beds = property.bedrooms {
                            Text("🛏 Bedrooms: \(beds)")
                        }
                        if let baths = property.bathrooms {
                            Text("🛁 Bathrooms: \(baths)")
                        }
                        if let area = property.area {
                            Text("📐 Area: \(Int(area)) sq.ft")
                        }
                    }
                    .font(.subheadline)
                    .foregroundStyle(.primary)

                    Spacer().frame(height: 80) // leave space for floating button
                }
                .padding()
            }

            // 🌐 Floating gold "View on Website" button
            VStack {
                Spacer()
                if let link = property.link,
                   let url = URL(string: link) {
                    Link(destination: url) {
                        HStack {
                            Image(systemName: "safari")
                            Text("View on Website")
                                .fontWeight(.bold)
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    }
                }
            }
        }
        .navigationTitle("Property Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}

#Preview {
    PropertyDetailView(
        property: Property(
            id: 1,
            title: "Luxury Apartment in JVC",
            price: 950000,
            location: "Jumeirah Village Circle, Dubai",
            image: "https://picsum.photos/seed/apartment/600/400",
            bedrooms: 2,
            bathrooms: 2,
            area: 1200,
            developerName: "Binghatti",
            developerLogo: "https://xsite.ae/images/binghatti.png",
            link: "https://xsite.ae/property/1234"
        )
    )
}

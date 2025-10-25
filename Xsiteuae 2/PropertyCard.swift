import SwiftUI

struct PropertyCard: View {
    let property: Property

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 🏙 Property Image
            AsyncImage(url: URL(string: property.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.5), .clear]),
                            startPoint: .bottom,
                            endPoint: .center
                        )
                    )
                    .cornerRadius(16)
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2))
                    ProgressView()
                }
                .frame(height: 200)
            }

            // 🏷 Property Title
            Text(property.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)

            // 💰 Price
            Text(property.price > 0 ? "AED \(Int(property.price))" : "AED —")
                .font(.subheadline.bold())
                .foregroundColor(.yellow)

            // 📍 Location
            Text(property.location)
                .font(.caption)
                .foregroundColor(.secondary)

            Divider()

            // 🧱 Developer Logo & Name
            HStack(spacing: 10) {
                if let logo = property.developerLogo,
                   let url = URL(string: logo) {
                    AsyncImage(url: url) { img in
                        img.resizable().scaledToFit()
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                    }
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                    .shadow(radius: 3)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(property.developerName ?? "Developer")
                        .font(.caption.bold())
                    Text("Dubai, UAE")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    PropertyCard(property: Property(
        id: 1,
        title: "Luxury 2BR Apartment in Downtown Dubai",
        price: 1950000,
        location: "Downtown Dubai",
        image: "https://picsum.photos/seed/emaar/600/400",
        bedrooms: 2,
        bathrooms: 2,
        area: 1250,
        developerName: "Emaar Properties",
        developerLogo: "https://upload.wikimedia.org/wikipedia/en/2/2f/Emaar_Properties_Logo.svg",
        link: "https://xsite.ae/property/1234"
    ))
}

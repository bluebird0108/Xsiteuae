import SwiftUI
import WebKit

struct PropertyDetailView: View {
    let property: Property

    // 💰 Format price
    private var priceText: String {
        property.price > 0 ? "AED \(Int(property.price))" : "AED —"
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    // 🖼 Image
                    AsyncImage(url: URL(string: property.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .white.opacity(0.15), radius: 8)

                    // 🏷 Title
                    Text(property.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 4)
                        .foregroundColor(.white)

                    // 💰 Price
                    Text(priceText)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.85))

                    // 📍 Location
                    Text(property.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Divider().background(Color.white.opacity(0.2))

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
                            .shadow(color: .white.opacity(0.1), radius: 4)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(property.developerName ?? "Developer")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Project by leading UAE developer")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    Divider().background(Color.white.opacity(0.2))

                    // 📐 Property Details
                    VStack(alignment: .leading, spacing: 8) {
                        Text("🛏 Bedrooms: \(property.bedrooms ?? 0)")
                        Text("🛁 Bathrooms: \(property.bathrooms ?? 0)")
                        Text("📐 Area: \(Int(property.area ?? 0)) sq.ft")
                    }
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))

                    Divider().background(Color.white.opacity(0.2))

                    // 🔗 Link to Website (since no description in model)
                    if let link = property.link, let url = URL(string: link) {
                        Link(destination: url) {
                            HStack(spacing: 8) {
                                Image(systemName: "link")
                                Text("View on Website")
                            }
                            .buttonStyleNeutral()
                        }
                        .padding(.vertical)
                    }

                    Spacer().frame(height: 100)
                }
                .padding()
            }

            // 💬 Floating Contact Buttons
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    // 📞 Call
                    Link(destination: URL(string: "tel:+971000000000")!) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Call")
                        }
                        .buttonStyleNeutral()
                    }

                    // 💬 WhatsApp
                    Link(destination: URL(string: "https://wa.me/971000000000")!) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("Chat")
                        }
                        .buttonStyleNeutral()
                    }

                    // 📧 Email
                    Link(destination: URL(string: "mailto:info@xsite.ae")!) {
                        HStack {
                            Image(systemName: "envelope.fill")
                            Text("Email")
                        }
                        .buttonStyleNeutral()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
            }
        }
        .navigationTitle("Property Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

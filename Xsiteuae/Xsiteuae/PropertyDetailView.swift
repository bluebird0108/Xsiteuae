import SwiftUI
import WebKit

struct PropertyDetailView: View {
    let property: Property

    private var priceText: String {
        property.price > 0 ? "AED \(Int(property.price))" : "AED —"
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    AsyncImage(url: URL(string: property.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.15)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .black.opacity(0.08), radius: 8)

                    Text(property.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 4)
                        .foregroundStyle(.primary)

                    Text(priceText)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)

                    Text(property.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Divider()

                    HStack(spacing: 10) {
                        if let logo = property.developerLogo,
                           let url = URL(string: logo) {
                            AsyncImage(url: url) { img in
                                img.resizable().scaledToFit()
                            } placeholder: {
                                Color.gray.opacity(0.15)
                            }
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.06), radius: 4)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(property.developerName ?? "Developer")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text("Project by leading UAE developer")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("🛏 Bedrooms: \(property.bedrooms ?? 0)")
                        Text("🛁 Bathrooms: \(property.bathrooms ?? 0)")
                        Text("📐 Area: \(Int(property.area ?? 0)) sq.ft")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.primary)

                    Divider()

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

            VStack {
                Spacer()
                HStack(spacing: 12) {
                    Link(destination: URL(string: "tel:+971000000000")!) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Call")
                        }
                        .buttonStyleNeutral()
                    }

                    Link(destination: URL(string: "https://wa.me/971000000000")!) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("Chat")
                        }
                        .buttonStyleNeutral()
                    }

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

import SwiftUI

struct AboutCompanyView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image("Logo_Xsite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(radius: 8)

                Text("Xsite Real Estate Brokers LLC")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 10) {
                    Label("📄 RERA License: 1234", systemImage: "checkmark.seal.fill")
                    Label("🏗️ Founded: 2023", systemImage: "calendar")
                    Label("👥 Agents: 97 Registered", systemImage: "person.3.fill")
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 6) {
                    Text("📍 Primary Service Areas")
                        .font(.headline)
                    Text("Jumeirah Village Circle (JVC), Meydan, Arjan, Al Furjan")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text("💼 About the Company")
                        .font(.headline)
                    Text("""
Xsite Real Estate Brokers LLC is a Dubai-based brokerage firm providing expert real estate services across the UAE. The company specializes in buying, selling, and leasing residential and commercial properties, with a strong focus on off-plan investments and portfolio advisory.

Our professional team of 97 multilingual agents is registered with RERA and dedicated to providing transparent, customer-focused real estate solutions. We operate in prime communities including JVC, Meydan, Arjan, and Al Furjan — connecting investors and residents with the best opportunities in Dubai.

Xsite also operates a dedicated Maintenance team and provides Holiday Homes services for landlords and guests, ensuring quality property care and premium short-stay experiences.
""")
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text("📞 Contact Information")
                        .font(.headline)
                    Label("Office 12B04, Tower B, Prime Business Centre, JVC, Dubai", systemImage: "mappin.and.ellipse")
                    Label("+971 4 368 7000", systemImage: "phone.fill")
                    Label("info@xsite.ae", systemImage: "envelope.fill")

                    Link(destination: URL(string: "https://xsite.ae")!) {
                        Label("Visit Website", systemImage: "globe")
                            .foregroundColor(.blue)
                    }

                    Link(destination: URL(string: "https://www.google.com/maps?q=Xsite+Real+Estate+Brokers+Dubai")!) {
                        Label("View on Google Maps", systemImage: "map.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                VStack(spacing: 4) {
                    Text("Licensed Real Estate Broker")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Text("App by Faraz Kazmi")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("About Company")
    }
}

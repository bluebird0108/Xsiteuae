import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Xsite Real Estate Brokers LLC")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)

                Text("""
Xsite Real Estate Brokers LLC is a Dubai-based brokerage established in 2023 with over 97 dedicated agents. We specialize in Ready, Off-Plan, and Leasing services across prime locations such as JVC, Meydan, Arjan, and Al Furjan.

Our mission is to connect investors and residents with the best property opportunities in the UAE, ensuring transparency, trust, and exceptional service.

Xsite also has a dedicated Maintenance team and offers professional Holiday Homes services for landlords and guests across the UAE.
""")
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(6)

                Divider().padding(.vertical)

                VStack(alignment: .leading, spacing: 8) {
                    Text("📧 Email: info@xsite.ae")
                    Text("🌍 Website: www.xsite.ae")
                    Text("📍 Location: Dubai, United Arab Emirates")
                }
                .font(.subheadline)
                .foregroundColor(.primary)
            }
            .padding()
        }
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}

#Preview {
    AboutUsView()
}

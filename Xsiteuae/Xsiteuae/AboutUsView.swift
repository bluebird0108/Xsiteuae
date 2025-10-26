import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("About Xsite Real Estate")
                        .font(.title.bold())
                        .foregroundColor(.white)

                    Text("""
We are a Dubai-based real estate brokerage focused on Ready, Off-Plan, and Leasing across prime communities such as Downtown, Dubai Marina, Business Bay, and Dubai Hills.

We work directly with leading developers like Emaar, DAMAC, Sobha, Nakheel, and Meraas to secure the best inventory for our clients.
""")
                    .foregroundColor(.white.opacity(0.95))

                    VStack(alignment: .leading, spacing: 8) {
                        Label("Email: info@xsiteuae.com", systemImage: "envelope.fill")
                        Label("Phone: +971-5X-XXXXXXX", systemImage: "phone.fill")
                        Label("Dubai, United Arab Emirates", systemImage: "mappin.and.ellipse")
                    }
                    .foregroundColor(.white)

                    Divider().overlay(Color.white.opacity(0.3))

                    Text("Developed by Faraz Kazmi")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.top, 8)
                }
                .padding()
            }
        }
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
    }
}

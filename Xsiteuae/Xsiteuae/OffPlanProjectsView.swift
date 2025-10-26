import SwiftUI

struct OffPlanProjectsView: View {
    let devList: [DevInfo] = [
        DevInfo(name: "Emaar", icon: "🏙", details: "Luxury communities like Downtown Dubai, Arabian Ranches, and Dubai Hills Estate."),
        DevInfo(name: "DAMAC", icon: "🏗", details: "Known for high-end apartments and branded villas."),
        DevInfo(name: "Sobha Realty", icon: "🏡", details: "Premium waterfront residences in Sobha Hartland and Sobha One."),
        DevInfo(name: "Meraas", icon: "🌆", details: "Iconic projects like City Walk, Bluewaters Island, and La Mer."),
        DevInfo(name: "Nakheel", icon: "🏖", details: "Developer of Palm Jumeirah and Jumeirah Islands."),
        DevInfo(name: "Ellington", icon: "🏢", details: "Boutique luxury developer with creative architecture."),
        DevInfo(name: "Azizi", icon: "🏘", details: "Affordable luxury apartments across Dubai communities.")
    ]

    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            ScrollView {
                VStack(spacing: 18) {
                    Text("Off-Plan Projects")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    ForEach(devList, id: \.name) { dev in
                        DevCard(dev: dev)
                            .padding(.horizontal)
                    }

                    Text("Developed by Faraz Kazmi")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 30)
                }
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Off-Plan Projects")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Model
struct DevInfo: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let details: String
}

// MARK: - Developer Card
struct DevCard: View {
    let dev: DevInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(dev.icon)
                    .font(.largeTitle)
                Text(dev.name)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Spacer()
            }

            Text(dev.details)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.black.opacity(0.25))
                .shadow(radius: 5)
        )
    }
}

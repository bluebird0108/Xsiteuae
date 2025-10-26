import SwiftUI

struct LeasingView: View {
    let rentals: [Property] = [
        Property(id: 101, title: "1BR Marina Walk", price: 110_000, location: "Dubai Marina", developer: "Select Group"),
        Property(id: 102, title: "Studio – Business Bay", price: 70_000, location: "Business Bay", developer: "DAMAC"),
        Property(id: 103, title: "2BR – JVC", price: 85_000, location: "Jumeirah Village Circle", developer: "Ellington")
    ]

    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            ScrollView {
                VStack(spacing: 16) {
                    Text("Leasing")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    ForEach(rentals) { rent in
                        RentalCard(property: rent)
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
    }
}

private struct RentalCard: View {
    let property: Property

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(property.title)
                .font(.headline)
                .foregroundColor(.white)
            Text(property.location)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            Text("Developer: \(property.developer)")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.8))
            Text("AED \(Int(property.price).formattedWithSeparator()) / year")
                .font(.title3.bold())
                .foregroundColor(Theme.goldAccent)

            HStack(spacing: 12) {
                Button {
                    // call placeholder
                } label: {
                    Label("Call", systemImage: "phone.fill")
                        .font(.subheadline.weight(.semibold))
                }
                .buttonStyle(.borderedProminent)

                Button {
                    // WhatsApp placeholder
                } label: {
                    Label("WhatsApp", systemImage: "message.fill")
                        .font(.subheadline.weight(.semibold))
                }
                .buttonStyle(.bordered)
            }
            .tint(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.black.opacity(0.25))
                .shadow(radius: 5)
        )
    }
}

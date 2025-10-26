import SwiftUI

struct ReadyPropertiesView: View {
    let properties: [Property] = [
        Property(id: 1, title: "Luxury Apartment – Downtown Dubai", price: 2450000, location: "Downtown Dubai", developer: "Emaar"),
        Property(id: 2, title: "2BR Marina View Apartment", price: 1850000, location: "Dubai Marina", developer: "Select Group"),
        Property(id: 3, title: "Family Villa – Arabian Ranches", price: 3200000, location: "Arabian Ranches", developer: "Emaar"),
        Property(id: 4, title: "1BR Modern Loft – JVC", price: 950000, location: "Jumeirah Village Circle", developer: "Ellington")
    ]
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(spacing: 16) {
                    Text("Ready Properties")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    ForEach(properties) { property in
                        PropertyCard(property: property)
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
        .navigationTitle("Ready Properties")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: – Property Card
struct PropertyCard: View {
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
            Text("AED \(property.price.formattedWithSeparator())")
                .font(.title3.bold())
                .foregroundColor(Theme.goldAccent)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.black.opacity(0.25))
                .shadow(radius: 5)
        )
    }
}

// MARK: – Number Formatter
extension Numeric {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(for: self) ?? "\(self)"
    }
}

import SwiftUI

struct OffPlanProjectsView: View {
    let developers: [Developer] = [
        Developer(name: "Emaar", logo: "🏙", description: "Luxury communities like Downtown Dubai, Arabian Ranches, and Dubai Hills Estate."),
        Developer(name: "DAMAC", logo: "🏗", description: "Known for stylish high-end developments and golf community villas."),
        Developer(name: "Sobha Realty", logo: "🏡", description: "Premium waterfront residences in Sobha Hartland and Sobha One."),
        Developer(name: "Meraas", logo: "🌆", description: "Creator of iconic projects like City Walk, Bluewaters Island, and La Mer."),
        Developer(name: "Nakheel", logo: "🏖", description: "Developer of Palm Jumeirah and Jumeirah Islands."),
        Developer(name: "Ellington", logo: "🏢", description: "Boutique luxury developer known for contemporary interiors."),
        Developer(name: "Azizi", logo: "🏘", description: "Affordable luxury apartments across Dubai’s top communities.")
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
                    
                    ForEach(developers, id: \.name) { developer in
                        DeveloperCard(developer: developer)
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

// MARK: – Developer Model
struct Developer {
    let name: String
    let logo: String
    let description: String
}

// MARK: – Developer Card
struct DeveloperCard: View {
    let developer: Developer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(developer.logo)
                    .font(.largeTitle)
                Text(developer.name)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            
            Text(developer.description)
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

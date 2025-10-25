import SwiftUI

struct Developer: Identifiable, Codable {
    var id = UUID()
    let name: String
    let logo: String
}

struct DeveloperListView: View {
    @State private var developers: [Developer] = [
        Developer(name: "Emaar Properties", logo: "https://upload.wikimedia.org/wikipedia/en/2/2f/Emaar_Properties_Logo.svg"),
        Developer(name: "DAMAC Properties", logo: "https://upload.wikimedia.org/wikipedia/en/1/1b/DAMAC_Properties_Logo.svg"),
        Developer(name: "Sobha Realty", logo: "https://upload.wikimedia.org/wikipedia/en/d/d3/Sobha_Realty_Logo.svg"),
        Developer(name: "Meraas", logo: "https://upload.wikimedia.org/wikipedia/en/6/6e/Meraas_logo.svg"),
        Developer(name: "Azizi Developments", logo: "https://upload.wikimedia.org/wikipedia/en/e/e5/Azizi_Developments_logo.svg"),
        Developer(name: "Nakheel", logo: "https://upload.wikimedia.org/wikipedia/en/a/a1/Nakheel_Logo.svg")
    ]

    var body: some View {
        NavigationView {
            List(developers) { dev in
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: dev.logo)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text(dev.name)
                        .font(.headline)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Developers")
        }
    }
}

#Preview {
    DeveloperListView()
}

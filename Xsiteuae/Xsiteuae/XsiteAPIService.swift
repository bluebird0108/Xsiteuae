import Foundation
import Combine // ✅ Required for ObservableObject

final class XsiteAPIService: ObservableObject {
    static let shared = XsiteAPIService()

    @Published var properties: [Property] = [] // ✅ Published so SwiftUI updates automatically
    private let baseURL = "https://xsite.ae/v1/property"

    func fetchProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else { return }

            do {
                let properties = try JSONDecoder().decode([Property].self, from: data)
                DispatchQueue.main.async {
                    self.properties = properties
                    completion(.success(properties))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

    /// Mock fallback data (for offline or testing)
    func fallbackProperties() -> [Property] {
        return [
            Property(
                id: 1,
                title: "Modern 2BR Apartment",
                price: 1200000,
                location: "Dubai Marina",
                image: "https://picsum.photos/seed/marina/600/400",
                bedrooms: 2,
                bathrooms: 2,
                area: 1100,
                developerName: "Emaar Properties",
                developerLogo: "https://upload.wikimedia.org/wikipedia/en/2/2f/Emaar_Properties_Logo.svg",
                link: "https://xsite.ae/property/1234"
            ),
            Property(
                id: 2,
                title: "Luxury Villa in Palm Jumeirah",
                price: 5200000,
                location: "Palm Jumeirah, Dubai",
                image: "https://picsum.photos/seed/palm/600/400",
                bedrooms: 5,
                bathrooms: 6,
                area: 4500,
                developerName: "Nakheel",
                developerLogo: "https://upload.wikimedia.org/wikipedia/en/a/a1/Nakheel_Logo.svg",
                link: "https://xsite.ae/property/5678"
            )
        ]
    }

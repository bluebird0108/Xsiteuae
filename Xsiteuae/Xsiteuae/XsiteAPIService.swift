import Foundation
import Combine // ✅ Required for ObservableObject

final class XsiteAPIService: ObservableObject {
    static let shared = XsiteAPIService()

    @Published var properties: [Property] = [] // ✅ Published so SwiftUI updates automatically
    private let baseURL = "https://xsite.ae/v1/property"

    func fetchProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            let fallback = self.fallbackProperties()
            DispatchQueue.main.async {
                self.properties = fallback
                completion(.success(fallback))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // If any error or bad response, deliver fallback
            if let error = error {
                let fallback = self.fallbackProperties()
                DispatchQueue.main.async {
                    self.properties = fallback
                    completion(.success(fallback))
                }
                print("API error: \(error.localizedDescription). Using fallback.")
                return
            }

            guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode), let data = data else {
                let fallback = self.fallbackProperties()
                DispatchQueue.main.async {
                    self.properties = fallback
                    completion(.success(fallback))
                }
                return
            }

            do {
                let properties = try JSONDecoder().decode([Property].self, from: data)
                DispatchQueue.main.async {
                    self.properties = properties
                    completion(.success(properties))
                }
            } catch {
                let fallback = self.fallbackProperties()
                DispatchQueue.main.async {
                    self.properties = fallback
                    completion(.success(fallback))
                }
            }
        }.resume()
    }

    /// Mock fallback data (for offline or testing)
    func fallbackProperties() -> [Property] {
        return [
            Property(
                id: 1,
                title: "Modern 2BR Apartment",
                price: 1_200_000,
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
                price: 5_200_000,
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
}

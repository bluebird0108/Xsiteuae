import Foundation
import SwiftUI
import Combine   // ✅ REQUIRED for @Published and ObservableObject

@MainActor
final class PropertyFinderService: ObservableObject {
    @Published var listings: [Property] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let baseURL = "https://api.propertyfinder.ae/v1/property"

    // MARK: - Load API Key from Config.plist
    private func getAPIKey(for keyName: String) -> String {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let key = dict[keyName] as? String
        else {
            fatalError("❌ Missing \(keyName) in Config.plist")
        }
        return key
    }

    // MARK: - Fetch properties
    func fetchProperties(limit: Int = 20) async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }

        let apiKey = getAPIKey(for: "PROPERTY_FINDER_API_KEY")
        guard let url = URL(string: "\(baseURL)?limit=\(limit)") else {
            await MainActor.run {
                self.errorMessage = "❌ Invalid API URL"
                self.isLoading = false
            }
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }

            let decoded = try JSONDecoder().decode([Property].self, from: data)
            await MainActor.run {
                self.listings = decoded
                self.isLoading = false
            }

        } catch {
            print("❌ API Fetch Error:", error.localizedDescription)
            await MainActor.run {
                self.errorMessage = "Could not load data, using fallback"
                self.isLoading = false
                self.useFallbackData(reason: error.localizedDescription)
            }
        }
    }

    // MARK: - Fallback demo data
    private func useFallbackData(reason: String) {
        self.listings = [
            Property(
                id: 1,
                title: "Modern 2BR Apartment",
                price: 1_200_000,
                location: "Dubai Marina",
                image: "https://picsum.photos/seed/apt1/600/400",
                bedrooms: 2,
                bathrooms: 2,
                area: 110.0,
                developerName: "Emaar",
                developerLogo: "https://xsite.ae/images/developers/emaar.png",
                link: "https://xsite.ae/property/1001"
            ),
            Property(
                id: 2,
                title: "Luxury Villa with Private Pool",
                price: 6_500_000,
                location: "Palm Jumeirah",
                image: "https://picsum.photos/seed/villa1/600/400",
                bedrooms: 5,
                bathrooms: 6,
                area: 650.0,
                developerName: "Nakheel",
                developerLogo: "https://xsite.ae/images/developers/nakheel.png",
                link: "https://xsite.ae/property/1002"
            ),
            Property(
                id: 3,
                title: "Cozy Studio Apartment",
                price: 450_000,
                location: "Jumeirah Village Circle",
                image: "https://picsum.photos/seed/studio1/600/400",
                bedrooms: 0,
                bathrooms: 1,
                area: 40.0,
                developerName: "Binghatti",
                developerLogo: "https://xsite.ae/images/developers/binghatti.png",
                link: "https://xsite.ae/property/1003"
            )
        ]
    }

    // MARK: - Compatibility (completion-based)
    func fetchProperties(limit: Int = 20, completion: @escaping (Result<[Property], Error>) -> Void) {
        Task {
            await fetchProperties(limit: limit)
            if let message = self.errorMessage {
                let err = NSError(domain: "PropertyFinderService",
                                  code: -1,
                                  userInfo: [NSLocalizedDescriptionKey: message])
                completion(.failure(err))
            } else {
                completion(.success(self.listings))
            }
        }
    }
}

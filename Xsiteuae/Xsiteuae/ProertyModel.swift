import Foundation
import SwiftUI
import Combine

@MainActor
final class PropertyFinderService: ObservableObject {
    @Published var listings: [Property] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let baseURL = "https://api.propertyfinder.ae/v1/property"

    // MARK: - Load API Key from Config.plist (non-fatal if missing)
    private func getAPIKey(for keyName: String) -> String? {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let key = dict[keyName] as? String,
            !key.isEmpty
        else {
            return nil
        }
        return key
    }

    // MARK: - Fetch properties
    func fetchProperties(limit: Int = 20) async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }

        guard let apiKey = getAPIKey(for: "PROPERTY_FINDER_API_KEY"),
              let url = URL(string: "\(baseURL)?limit=\(limit)") else {
            await MainActor.run {
                self.errorMessage = "Using demo data"
                self.isLoading = false
                self.useFallbackData(reason: "Missing API key or invalid URL")
            }
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                let preview = String(data: data, encoding: .utf8)?.prefix(800) ?? ""
                print("PropertyFinder status: \(httpResponse.statusCode)")
                print("Response preview:\n\(preview)\n---")
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }

            // Attempt to decode as a top-level array of Property.
            do {
                let decoded = try JSONDecoder().decode([Property].self, from: data)
                await MainActor.run {
                    self.listings = decoded
                    self.isLoading = false
                }
            } catch {
                // Log some helpful info and fall back.
                print("Decoding error: \(error)")
                if let jsonObject = try? JSONSerialization.jsonObject(with: data),
                   let json = jsonObject as? [String: Any] {
                    print("Top-level keys: \(Array(json.keys))")
                }
                await MainActor.run {
                    self.errorMessage = "Using demo data"
                    self.isLoading = false
                    self.useFallbackData(reason: "Decoding failed: \(error.localizedDescription)")
                }
            }
        } catch {
            await MainActor.run {
                print("Network error: \(error)")
                self.errorMessage = "Using demo data"
                self.isLoading = false
                self.useFallbackData(reason: error.localizedDescription)
            }
        }
    }

    // MARK: - Fallback demo data
    private func useFallbackData(reason: String) {
        print("Using fallback data. Reason: \(reason)")
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

    // MARK: - Completion-based compatibility
    func fetchProperties(limit: Int = 20, completion: @escaping (Result<[Property], Error>) -> Void) {
        Task {
            await fetchProperties(limit: limit)
            if self.listings.isEmpty {
                self.useFallbackData(reason: "Empty result")
            }
            completion(.success(self.listings))
        }
    }
}

import Foundation
import SwiftUI
import Combine

@MainActor
final class PropertyFinderService: ObservableObject {
    @Published var listings: [Property] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Offline: Fetch properties from demo data only
    func fetchProperties(limit: Int = 20) async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }

        // Simulate a short load to keep UI behavior consistent
        try? await Task.sleep(nanoseconds: 250_000_000)

        await MainActor.run {
            self.useFallbackData(reason: "Offline mode")
            // If a limit is requested, trim the array
            if listings.count > limit {
                listings = Array(listings.prefix(limit))
            }
            self.isLoading = false
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

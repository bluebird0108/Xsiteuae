import Foundation
import Combine

// MARK: - PropertyService
@MainActor
final class PropertyService: ObservableObject {
    @Published var listings: [Property] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Fetch using PropertyFinderService (replaces missing XsiteAPIService)
    func fetchXsiteProperties(limit: Int = 20) {
        isLoading = true
        errorMessage = nil

        let finder = PropertyFinderService()
        finder.fetchProperties(limit: limit) { [weak self] (result: Result<[Property], Error>) in
            switch result {
            case .success(let properties):
                self?.listings = properties
                self?.isLoading = false
            case .failure(let error):
                print("❌ Finder Error:", error.localizedDescription)
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
                // Use fallback if API fails
                self?.useFallbackData(reason: error.localizedDescription)
            }
        }
    }

    // MARK: - Fetch from Property Finder API (optional)
    func fetchFinderProperties(using finder: PropertyFinderService) async {
        await finder.fetchProperties()
        self.listings = finder.listings
    }

    // MARK: - Fallback data for offline/testing
    private func useFallbackData(reason: String) {
        print("⚠️ Using fallback data because: \(reason)")
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
}

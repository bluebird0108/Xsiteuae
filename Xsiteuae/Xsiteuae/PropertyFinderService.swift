// PropertyFinderService.swift
import Foundation
import Combine

final class PropertyFinderService: ObservableObject {
    @Published private(set) var listings: [Property] = []

    // Completion-based API used by PropertyService.fetchXsiteProperties(limit:)
    func fetchProperties(limit: Int = 20, completion: @escaping (Result<[Property], Error>) -> Void) {
        // Simulate a network delay and return mock data
        let data = Self.sampleProperties()
        let limited = Array(data.prefix(limit))
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            completion(.success(limited))
        }
    }

    // Async API used by PropertyService.fetchFinderProperties(using:)
    @MainActor
    func fetchProperties() async {
        // Simulate a network delay and then set listings
        try? await Task.sleep(nanoseconds: 300_000_000)
        self.listings = Self.sampleProperties()
    }

    // MARK: - Sample data
    private static func sampleProperties() -> [Property] {
        return [
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

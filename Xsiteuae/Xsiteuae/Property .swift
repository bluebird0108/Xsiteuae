import Foundation

struct Property: Identifiable, Hashable {
    // Core fields
    let id: Int
    let title: String
    let price: Double
    let location: String

    // Legacy/simple developer name
    let developer: String?

    // Extended fields used across the app
    let image: String?
    let bedrooms: Int?
    let bathrooms: Int?
    let area: Double?
    let developerName: String?
    let developerLogo: String?
    let link: String?

    // MARK: - Initializers

    // Simple initializer (used by ReadyPropertiesView & LeasingView)
    init(id: Int, title: String, price: Double, location: String, developer: String) {
        self.id = id
        self.title = title
        self.price = price
        self.location = location
        self.developer = developer

        self.image = nil
        self.bedrooms = nil
        self.bathrooms = nil
        self.area = nil
        self.developerName = nil
        self.developerLogo = nil
        self.link = nil
    }

    // Extended initializer (used by PropertyService / cards / details)
    init(
        id: Int,
        title: String,
        price: Double,
        location: String,
        image: String? = nil,
        bedrooms: Int? = nil,
        bathrooms: Int? = nil,
        area: Double? = nil,
        developerName: String? = nil,
        developerLogo: String? = nil,
        link: String? = nil
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.location = location

        self.developer = developerName // map to legacy if needed

        self.image = image
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.area = area
        self.developerName = developerName
        self.developerLogo = developerLogo
        self.link = link
    }
}

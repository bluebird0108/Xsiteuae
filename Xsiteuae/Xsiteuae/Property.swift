struct Property: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let location: String
    let image: String?
    let bedrooms: Int?
    let bathrooms: Int?
    let area: Double?
    let developerName: String?
    let developerLogo: String?
    let link: String?    // property.link.👈 Add this line
}

import Foundation

struct Property: Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let location: String
    let developer: String
    let bedrooms: Int = 2
    let bathrooms: Int = 2
    let areaSqft: Int = 900
    let imageName: String? = nil
}

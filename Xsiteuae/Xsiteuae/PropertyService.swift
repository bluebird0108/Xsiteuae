import Foundation
import Combine

@MainActor
final class PropertyService: ObservableObject {
    @Published var listings: [Property] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let xsiteBase = "https://xsite.ae/v1/property"
    private let propertyFinderBase = "https://api.propertyfinder.ae/v1/listings"

    func fetchProperties(search: String? = nil, filter: String? = nil) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            async let a = fetchFromXsite(search: search, filter: filter)
            async let b = fetchFromPropertyFinder(search: search)

            let (xsite, pf) = try await (a, b)
            self.listings = xsite + pf
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    private func fetchFromXsite(search: String?, filter: String?) async throws -> [Property] {
        var urlString = xsiteBase
        var items: [String] = []
        if let s = search, !s.isEmpty {
            let enc = s.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? s
            items.append("search=\(enc)")
        }
        if let f = filter, !f.isEmpty {
            let enc = f.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? f
            items.append("type=\(enc)")
        }
        if !items.isEmpty { urlString += "?" + items.joined(separator: "&") }

        guard let url = URL(string: urlString) else { return [] }
        let (responseData, resp) = try await URLSession.shared.data(from: url)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { return [] }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Property].self, from: responseData)
    }

    private func fetchFromPropertyFinder(search: String?) async throws -> [Property] {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let encoded = dict["PROPERTYFINDER_API_KEY_BASE64"] as? String,
            let keyData = Data(base64Encoded: encoded),
            let token = String(data: keyData, encoding: .utf8)
        else { return [] }

        var urlString = propertyFinderBase
        if let s = search, !s.isEmpty {
            let enc = s.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? s
            urlString += "?q=\(enc)"
        }
        guard let url = URL(string: urlString) else { return [] }

        var req = URLRequest(url: url)
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        let (responseData, resp) = try await URLSession.shared.data(for: req)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { return [] }

        struct PFListing: Codable {
            let id: Int
            let title: String?
            let price: Double?
            let location: String?
            let thumbnail: String?
            let developerName: String?
            let developerLogo: String?
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let pf = try decoder.decode([PFListing].self, from: responseData)
        return pf.map {
            Property(
                id: $0.id,
                title: $0.title ?? "Untitled",
                price: $0.price ?? 0,
                location: $0.location ?? "Dubai",
                image: $0.thumbnail,
                bedrooms: nil,
                bathrooms: nil,
                area: nil,
                developerName: $0.developerName,
                developerLogo: $0.developerLogo,
                link: nil // Explicit to satisfy Property initializer
            )
        }
    }
}

import Foundation

class XsiteAPIService {
    static let shared = XsiteAPIService()
    private let baseURL = "https://xsite.ae/v1/property"

    func fetchProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let properties = try JSONDecoder().decode([Property].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(properties))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

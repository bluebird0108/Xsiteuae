import Foundation

struct XsitePost: Codable, Identifiable {
    let id: Int
    let date: String
    let slug: String
    let link: String
    let title: Rendered
    let content: Rendered

    struct Rendered: Codable {
        let rendered: String
    }
}



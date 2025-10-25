import SwiftUI

struct BlogListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Latest News") {
                    NavigationLink("RERA Updates", destination: Text("RERA updates content coming soon."))
                    NavigationLink("Market Trends", destination: Text("Market trends content coming soon."))
                    NavigationLink("Mortgage Tips", destination: Text("Mortgage tips content coming soon."))
                }
            }
            .navigationTitle("News")
        }
    }
}

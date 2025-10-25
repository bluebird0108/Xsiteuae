import SwiftUI

struct TeamMember: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let phone: String
    let whatsapp: String
}

struct TeamView: View {
    let team: [TeamMember] = [
        .init(name: "Faraz Kazmi", title: "Managing Director", phone: "+971500000000", whatsapp: "+971500000000"),
        .init(name: "Rohan Khan", title: "Property Consultant", phone: "+971520000000", whatsapp: "+971520000000"),
        .init(name: "Sara Malik", title: "Leasing Agent", phone: "+971540000000", whatsapp: "+971540000000")
    ]

    var body: some View {
        NavigationStack {
            List(team) { m in
                VStack(alignment: .leading, spacing: 6) {
                    Text(m.name).font(.headline)
                    Text(m.title).font(.subheadline).foregroundStyle(.secondary)
                    HStack {
                        Link(destination: URL(string: "tel://\(m.phone)")!) {
                            Label("Call", systemImage: "phone.fill")
                        }
                        Spacer()
                        Link(destination: URL(string: "https://wa.me/\(m.whatsapp)")!) {
                            Label("WhatsApp", systemImage: "message.fill")
                        }
                    }.buttonStyle(.borderedProminent).tint(.yellow)
                }.padding(.vertical, 6)
            }
            .navigationTitle("Meet Our Team")
        }
    }
}

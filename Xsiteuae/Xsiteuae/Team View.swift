import SwiftUI

struct TeamMember: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let imageName: String
}

struct TeamView: View {
    let teamMembers: [TeamMember] = [
        TeamMember(name: "Faraz Kazmi", role: "Developer", imageName: "faraz"),
        TeamMember(name: "Rohan Sheikh", role: "Sales Manager", imageName: "rohan"),
        TeamMember(name: "Ayesha Malik", role: "Property Consultant", imageName: "ayesha")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(teamMembers) { member in
                        VStack {
                            Image(member.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .shadow(radius: 5)

                            Text(member.name)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(member.role)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .padding()
            }
            .navigationTitle("Meet Our Team")
        }
    }
}

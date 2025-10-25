import SwiftUI

struct ContactView: View {
    var body: some View {
        Form {
            Section(header: Text("Contact Us")) {
                Label("Office 12B04, Tower B, Prime Business Centre, JVC, Dubai", systemImage: "mappin.and.ellipse")
                Link(destination: URL(string: "tel:+97143687000")!) {
                    Label("+971 4 368 7000", systemImage: "phone.fill")
                }
                Link(destination: URL(string: "mailto:info@xsite.ae")!) {
                    Label("info@xsite.ae", systemImage: "envelope.fill")
                }
                Link(destination: URL(string: "https://xsite.ae")!) {
                    Label("xsite.ae", systemImage: "globe")
                }
            }
        }
        .navigationTitle("Contact")
    }
}

#Preview {
    ContactView()
}

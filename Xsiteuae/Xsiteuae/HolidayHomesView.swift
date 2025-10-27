import SwiftUI

struct HolidayHomesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(systemName: "bed.double.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                    .padding(.top)

                Text("Holiday Homes by Xsite")
                    .font(.title2)
                    .bold()

                Text("""
Experience luxury short-term stays in Dubai with Xsite Holiday Homes.  
We manage furnished apartments and villas for short stays, providing:
• Professional guest management  
• Housekeeping and 24/7 support  
• DLD-approved holiday home licensing  
• Maximum returns for property owners
""")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Holiday Homes")
    }
}

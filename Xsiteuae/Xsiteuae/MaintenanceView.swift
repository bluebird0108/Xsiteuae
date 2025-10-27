import SwiftUI

struct MaintenanceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(systemName: "wrench.and.screwdriver")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top)

                Text("Property Maintenance")
                    .font(.title2)
                    .bold()

                Text("""
Xsite provides professional property maintenance services to landlords and tenants, ensuring your property remains in perfect condition throughout the year.

Our maintenance team handles:
• Plumbing and electrical repairs  
• Air conditioning servicing  
• Painting and general upkeep  
• Emergency support and regular inspections
""")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Maintenance")
    }
}

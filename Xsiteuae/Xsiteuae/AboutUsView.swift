import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image("Logo_Xsite")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top)

                Text("About Xsite Real Estate Brokers LLC")
                    .font(.title)
                    .bold()

                Text("""
Xsite Real Estate Brokers LLC is a full-service real estate brokerage based in Dubai. We specialize in Ready Properties, Off-Plan Projects, Leasing, Property Management, Property Maintenance, and Holiday Homes.

With multiple branches across the UAE, Xsite is known for transparent transactions, client satisfaction, and a professional approach guided by Dubai Land Department (DLD) and RERA regulations.

Our goal is to provide clients with smart real estate solutions — whether buying, selling, renting, or investing.
""")
                .font(.body)
                .foregroundColor(.secondary)

                Divider()

                Text("Our Services")
                    .font(.headline)

                Text("""
• Ready Properties: Expert guidance for buyers and sellers across Dubai’s prime communities.
• Off-Plan Projects: Access to top developer launches, early allocations, and investment advisory.
• Leasing: End-to-end tenant and landlord services with compliant contracts and documentation.
• Property Management: Hassle-free management, inspections, renewals, and rent optimization.
• Property Maintenance (In-House): Dedicated maintenance team for repairs, preventive care, and 24/7 support to keep your assets in top condition.
• Holiday Homes (Licensed): Fully managed short-stay solutions including furnishing, listing optimization, guest relations, housekeeping, and dynamic pricing to maximize returns.
""")
                .font(.body)
                .foregroundColor(.secondary)

                Divider()

                Text("Maintenance Company")
                    .font(.headline)

                Text("""
Our in-house maintenance company provides reliable, cost-effective services covering:
• AC servicing and duct cleaning
• Electrical and plumbing
• Carpentry and handyman work
• Painting and waterproofing
• Preventive maintenance packages

Having a dedicated team ensures faster turnaround, quality control, and better value for landlords and tenants alike.
""")
                .font(.body)
                .foregroundColor(.secondary)

                Divider()

                Text("Holiday Homes Company")
                    .font(.headline)

                Text("""
Our Holiday Homes division is licensed and compliant with local regulations, offering:
• Full setup and furnishing
• Professional photography and multi-platform listings
• Guest screening, check-in/out, and 24/7 support
• Housekeeping and maintenance coordination
• Revenue reporting and owner dashboards

This end-to-end model helps property owners unlock higher yields through short-term rentals while maintaining an exceptional guest experience.
""")
                .font(.body)
                .foregroundColor(.secondary)

                Divider()

                Text("Why Choose Xsite")
                    .font(.headline)

                Text("""
• Transparent, data-driven advisory
• Strong developer and industry relationships
• In-house maintenance and holiday homes for true end-to-end service
• Compliance-led operations aligned with DLD and RERA
• Local expertise with a client-first approach
""")
                .font(.body)
                .foregroundColor(.secondary)

                Text("Developer: Faraz Kazmi")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("About Us")
    }
}

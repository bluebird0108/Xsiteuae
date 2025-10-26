import SwiftUI

struct LeasingView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedGradientBackground()

                VStack(spacing: 20) {
                    Text("Leasing Services")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 30)

                    Text("Find apartments, villas, and commercial spaces for rent across Dubai. Manage your tenancy, renewals, and Ejari services easily with Xsite Real Estate Brokers.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.horizontal)

                    Spacer()

                    Text("Developed by Faraz Kazmi")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.bottom, 30)
                }
            }
            .navigationTitle("Leasing")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

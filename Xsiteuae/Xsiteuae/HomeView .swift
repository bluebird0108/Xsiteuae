import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedGradientBackground()

                VStack(spacing: 20) {
                    Text("Welcome to Xsite Real Estate Brokers LLC")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text("Developed by Faraz Kazmi")
                        .foregroundColor(.white.opacity(0.85))
                        .font(.footnote)
                }
                .padding(.vertical, 40)
                .padding(.horizontal)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

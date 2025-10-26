import SwiftUI

struct ReadyProjectsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedGradientBackground()

                VStack(spacing: 20) {
                    Text("Ready Properties")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 30)

                    Text("Explore ready-to-move homes, apartments, and villas available across Dubai.")
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
            .navigationTitle("Ready Projects")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

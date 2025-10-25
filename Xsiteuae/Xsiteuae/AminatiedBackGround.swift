import SwiftUI

struct AnimatedBackground: View {
    @State private var moveGradient = false
    var isDarkMode: Bool

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: isDarkMode ? [.black, .gray, .white.opacity(0.1)] : [.white, .gray.opacity(0.3), .black.opacity(0.05)]),
            startPoint: moveGradient ? .topLeading : .bottomTrailing,
            endPoint: moveGradient ? .bottomTrailing : .topLeading
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: moveGradient)
        .onAppear {
            moveGradient.toggle()
        }
    }
}

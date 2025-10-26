import SwiftUI

// MARK: - Global Theme and Styling
struct Theme {
    static let primaryColor = Color.black
    static let secondaryColor = Color.white
    static let accentColor = Color.gray.opacity(0.8)
    static let goldAccent = Color(red: 0.85, green: 0.75, blue: 0.45)

    static let gradientColors = [
        Color.black.opacity(0.9),
        Color.gray.opacity(0.8),
        Color.white.opacity(0.9)
    ]
}

// MARK: - Animated Background
struct AnimatedGradientBackground: View {
    @State private var animate = false

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: Theme.gradientColors),
            startPoint: animate ? .topLeading : .bottomTrailing,
            endPoint: animate ? .bottomTrailing : .topLeading
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 8).repeatForever(autoreverses: true), value: animate)
        .onAppear {
            animate.toggle()
        }
    }
}

// MARK: - Global Text Style
extension Text {
    func titleStyle() -> some View {
        self
            .font(.system(size: 26, weight: .bold))
            .foregroundColor(Theme.primaryColor)
    }

    func subtitleStyle() -> some View {
        self
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(Theme.accentColor)
    }
}

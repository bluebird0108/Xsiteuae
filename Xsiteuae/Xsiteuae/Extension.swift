import SwiftUI

private struct PressableModifier: ViewModifier {
    @GestureState private var isPressed = false
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .opacity(isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.12), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .updating($isPressed) { _, state, _ in
                        state = true
                    }
            )
    }
}

extension View {
    func buttonStyleNeutral() -> some View {
        modifier(NeutralButtonModifier())
    }
}

private struct NeutralButtonModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .font(.subheadline.bold())
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .foregroundStyle(.primary)
            .background(
                Group {
                    if colorScheme == .dark {
                        Color.white.opacity(0.06)
                    } else {
                        Color.black.opacity(0.04)
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(
                        colorScheme == .dark
                        ? Color.white.opacity(0.12)
                        : Color.black.opacity(0.12),
                        lineWidth: 1
                    )
            )
            .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.25 : 0.08), radius: 4, x: 0, y: 2)
            .contentShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .modifier(PressableModifier())
    }
}

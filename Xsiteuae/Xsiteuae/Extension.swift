import SwiftUI

extension View {
    func buttonStyleNeutral() -> some View {
        self
            .font(.subheadline.bold())
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .foregroundColor(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
    }
}

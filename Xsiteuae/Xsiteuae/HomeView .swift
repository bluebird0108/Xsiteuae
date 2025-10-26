// In HomeView body, replace VStack with:

import SwiftUI
NavigationStack {
    VStack(spacing: 24) {
        // ... (same content)
    }
    .padding()
}

// In NavigationButton, fix font line:
Text(title)
    .font(.system(size: 18, weight: .semibold))
    .foregroundColor(.white)

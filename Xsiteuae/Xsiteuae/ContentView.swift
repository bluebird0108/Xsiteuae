import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Welcome to Xsite UAE")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Spacer()

            Text("Real Estate App by Faraz Kazmi")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
        }
        .accentColor(.black) // or .white depending on your theme
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}

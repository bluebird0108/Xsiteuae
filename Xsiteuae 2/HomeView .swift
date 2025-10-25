import SwiftUI

struct HomeView: View {
    @State private var searchText = ""

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LinearGradient(colors: [.black, .black.opacity(0.85)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer().frame(height: 30)

                Image("Logo_Xsite")
                    .resizable().scaledToFit().frame(width: 140, height: 140)
                    .shadow(color: .yellow.opacity(0.6), radius: 10, x: 0, y: 0)

                Text("Xsite Real Estate Brokers LLC")
                    .foregroundStyle(.white).font(.title3).bold()

                HStack {
                    Image(systemName: "magnifyingglass").foregroundStyle(.gray)
                    TextField("Search developer, area, or project…", text: $searchText)
                        .textFieldStyle(.plain).foregroundStyle(.white)
                }
                .padding().background(Color.white.opacity(0.08)).clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                VStack(spacing: 12) {
                    HomeButton(title: "🏡 Ready Properties", color: .yellow)
                    HomeButton(title: "🏗 Off‑Plan Projects", color: .yellow)
                    HomeButton(title: "🏠 Leasing", color: .yellow)
                    HomeButton(title: "💰 Mortgage Calculator", color: .yellow)
                    HomeButton(title: "📞 Contact Us", color: .yellow)
                }.padding(.horizontal)

                Spacer()
            }

            Button {} label: {
                Image(systemName: "sparkles")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(width: 56, height: 56)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .shadow(radius: 8)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 26)
        }
    }
}

private struct HomeButton: View {
    let title: String
    let color: Color
    var body: some View {
        Button {} label: {
            Text(title).foregroundStyle(.black).font(.headline)
                .frame(maxWidth: .infinity).padding()
                .background(color.gradient).clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

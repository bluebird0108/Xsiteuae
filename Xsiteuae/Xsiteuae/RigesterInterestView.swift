import SwiftUI

struct RegisterInterestView: View {
    let property: Property
    @State private var fullName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var message = ""
    @State private var isSubmitted = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // 🏙️ Property Image + Title
                AsyncImage(url: URL(string: property.image ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 220)
                        .clipped()
                        .cornerRadius(14)
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(height: 220)
                        .cornerRadius(14)
                        .overlay(
                            ProgressView()
                        )
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(property.title)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)

                    Text("💰 AED \(property.price)")
                        .font(.headline)
                        .foregroundColor(.green)

                    Text("📍 \(property.location)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    if let url = URL(string: property.link ?? "") {
                        Link("🔗 View on Website", destination: url)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)

                Divider()
                    .background(Color.white.opacity(0.2))

                // 🧍 User Details Form
                VStack(spacing: 16) {
                    TextField("Full Name", text: $fullName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.words)

                    TextField("Phone Number", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)

                    TextField("Email Address", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)

                    TextEditor(text: $message)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        .overlay(
                            Text(message.isEmpty ? "Your message (optional)" : "")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 8),
                            alignment: .topLeading
                        )

                    Button(action: submitInterest) {
                        Text(isSubmitted ? "✅ Submitted" : "📩 Register Interest")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isSubmitted ? Color.green : Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .animation(.easeInOut, value: isSubmitted)
                    }
                    .disabled(isSubmitted)
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(16)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationTitle("Register Interest")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Submit Action
    func submitInterest() {
        // 🔹 Here you can send details to an API endpoint later
        print("Submitting interest for \(property.title)")
        print("Name: \(fullName), Phone: \(phone), Email: \(email)")
        isSubmitted = true
    }
}


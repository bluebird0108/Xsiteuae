import SwiftUI

struct LoginView: View {
    @State private var isEmployee = true
    @State private var name = ""
    @State private var email = ""
    @State private var mobile = ""

    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            VStack(spacing: 16) {
                Picker("", selection: $isEmployee) {
                    Text("Employee").tag(true)
                    Text("Guest").tag(false)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Group {
                    if isEmployee {
                        TextField("Work Email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.roundedBorder)
                        SecureField("Password", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    } else {
                        TextField("Full Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                        TextField("Mobile (+971…)", text: $mobile)
                            .keyboardType(.phonePad)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding(.horizontal)

                Button {
                    // Placeholder auth / save locally
                } label: {
                    Text(isEmployee ? "Login" : "Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .padding(.horizontal)

                Spacer()

                Text("Developed by Faraz Kazmi")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(.top, 24)
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}

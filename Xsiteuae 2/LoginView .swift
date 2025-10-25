import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isEmployee = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("", selection: $isEmployee) {
                    Text("Employee").tag(true)
                    Text("Guest").tag(false)
                }.pickerStyle(.segmented).padding(.horizontal)

                TextField("Email", text: $email).textInputAutocapitalization(.never).keyboardType(.emailAddress)
                    .padding().background(Color(.systemGray6)).clipShape(RoundedRectangle(cornerRadius: 12)).padding(.horizontal)
                SecureField("Password", text: $password)
                    .padding().background(Color(.systemGray6)).clipShape(RoundedRectangle(cornerRadius: 12)).padding(.horizontal)

                Button("Sign In") {}
                    .frame(maxWidth: .infinity).padding()
                    .background(Color.yellow).foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12)).padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Login")
        }
    }
}

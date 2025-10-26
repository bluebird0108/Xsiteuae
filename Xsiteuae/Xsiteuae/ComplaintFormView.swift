import SwiftUI

struct ComplaintFormView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var message = ""

    @State private var submitted = false

    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            Form {
                Section(header: Text("Your Details")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                }

                Section(header: Text("Complaint")) {
                    TextEditor(text: $message)
                        .frame(minHeight: 140)
                }

                Button {
                    submitted = true
                } label: {
                    Label("Submit", systemImage: "paperplane.fill")
                }
            }
            .scrollContentBackground(.hidden)
            .alert("Submitted", isPresented: $submitted) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your complaint has been recorded.")
            }
        }
        .navigationTitle("Complaint Form")
        .navigationBarTitleDisplayMode(.inline)
    }
}

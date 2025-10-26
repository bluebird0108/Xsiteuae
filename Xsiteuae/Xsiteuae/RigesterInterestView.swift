import SwiftUI

struct RegisterInterestView: View {
    @State private var project = ""
    @State private var name = ""
    @State private var phone = ""
    @State private var notes = ""
    @State private var submitted = false

    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            Form {
                Section(header: Text("Project")) {
                    TextField("Project / Community", text: $project)
                }

                Section(header: Text("Your Details")) {
                    TextField("Full Name", text: $name)
                    TextField("Phone (+971…)", text: $phone)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(minHeight: 120)
                }

                Button {
                    submitted = true
                } label: {
                    Label("Register Interest", systemImage: "checkmark.seal.fill")
                }
            }
            .scrollContentBackground(.hidden)
            .alert("Submitted", isPresented: $submitted) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Thank you. Our team will contact you shortly.")
            }
        }
        .navigationTitle("Register Interest")
        .navigationBarTitleDisplayMode(.inline)
    }
}

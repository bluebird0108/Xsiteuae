import SwiftUI

struct AIAssistantView: View {
    @State private var query = ""
    @State private var transcript: [String] = ["Ask me about developers, fees, or availability."]

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(transcript, id: \.self) { line in
                            Text(line).frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10).background(Color(.systemGray6)).clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding()
                }
                HStack {
                    TextField("Ask Xsite AI…", text: $query)
                        .textFieldStyle(.roundedBorder)
                    Button("Send") {
                        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        transcript.append("You: " + query)
                        transcript.append("AI: (demo reply) We’ll wire this to your API / OpenAI key later.")
                        query = ""
                    }
                    .buttonStyle(.borderedProminent).tint(.yellow).foregroundStyle(.black)
                }.padding()
            }
            .navigationTitle("Ask Xsite AI")
        }
    }
}

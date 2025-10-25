import SwiftUI

struct AIAssistantView: View {
    @State private var query = ""
    @State private var transcript: [ChatLine] = [
        .ai("Hi! I’m Xsite AI. Ask about developers, fees, availability, or mortgages.")
    ]
    @State private var showClearConfirm = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Crystal white background
                Color.white.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header with logo and title
                    header

                    // Quick action chips
                    quickActions
                        .padding(.horizontal)
                        .padding(.top, 6)

                    Divider().padding(.top, 6)

                    // Chat area
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 12) {
                                ForEach(transcript) { line in
                                    ChatBubble(line: line)
                                        .id(line.id)
                                        .padding(.horizontal)
                                }
                                Spacer(minLength: 8)
                            }
                            .padding(.top, 12)
                        }
                        .background(Color.white)
                        .task(id: transcript.count) {
                            if let lastID = transcript.last?.id {
                                withAnimation(.easeOut) {
                                    proxy.scrollTo(lastID, anchor: .bottom)
                                }
                            }
                        }
                    }

                    // Input bar
                    inputBar
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                }
            }
            .navigationTitle("Ask Xsite AI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showClearConfirm = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.black)
                    }
                    .confirmationDialog("Clear conversation?", isPresented: $showClearConfirm) {
                        Button("Clear All", role: .destructive) {
                            transcript.removeAll()
                            transcript.append(.ai("Chat cleared. How can I help you next?"))
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
            }
        }
        .tint(.black)
    }

    // MARK: - Header
    private var header: some View {
        VStack(spacing: 10) {
            Image("Logo_Xsite")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 6)

            Text("Xsite AI Assistant")
                .font(.title3).bold()
                .foregroundStyle(.black)

            Text("Real‑time help with developers, fees, availability, and more.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 12)
        .padding(.bottom, 6)
        .background(Color.white)
    }

    // MARK: - Quick Actions
    private var quickActions: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(QuickAction.samples) { action in
                    Button {
                        handleQuickAction(action.prompt)
                    } label: {
                        HStack(spacing: 6) {
                            if let icon = action.icon {
                                Image(systemName: icon)
                            }
                            Text(action.title)
                        }
                        .font(.subheadline.weight(.semibold))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .foregroundStyle(.white)
                        .background(glossyBlack)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.18), radius: 6, x: 0, y: 3)
                    }
                }
            }
            .padding(.vertical, 6)
        }
    }

    // MARK: - Input Bar
    private var inputBar: some View {
        HStack(spacing: 10) {
            // Text field
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .foregroundStyle(.black.opacity(0.7))
                TextField("Ask Xsite AI…", text: $query, axis: .vertical)
                    .textFieldStyle(.plain)
                    .foregroundStyle(.black)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.black.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.black.opacity(0.12), lineWidth: 1)
            )

            // Send button
            Button(action: send) {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 42, height: 42)
                    .background(glossyBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: .black.opacity(0.22), radius: 8, x: 0, y: 4)
            }
            .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
        }
    }

    // MARK: - Actions
    private func send() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        transcript.append(.user(trimmed))
        // Demo response. Replace with your API integration later.
        transcript.append(.ai("Thanks for your question. (Demo) We’ll connect this to your API soon."))
        query = ""
    }

    private func handleQuickAction(_ prompt: String) {
        transcript.append(.user(prompt))
        // Demo response
        switch prompt {
        case _ where prompt.localizedCaseInsensitiveContains("developer"):
            transcript.append(.ai("Popular developers include Emaar, Nakheel, Dubai Properties, and Damac. What developer are you interested in?"))
        case _ where prompt.localizedCaseInsensitiveContains("fees"):
            transcript.append(.ai("Typical fees: 4% DLD fee, 2% agency commission (varies), AED 4,200 trustee fee, and admin/POA if applicable."))
        case _ where prompt.localizedCaseInsensitiveContains("availability"):
            transcript.append(.ai("Availability changes daily. Would you like to share your budget and preferred area so I can narrow options?"))
        case _ where prompt.localizedCaseInsensitiveContains("mortgage"):
            transcript.append(.ai("For residents, LTV up to 80% for first property; non‑residents up to ~60–65%. Would you like a quick estimate?"))
        case _ where prompt.localizedCaseInsensitiveContains("contact"):
            transcript.append(.ai("You can call +971 4 368 7000 or email info@xsite.ae. Prefer WhatsApp or phone?"))
        default:
            transcript.append(.ai("Got it. I’ll prepare details for you."))
        }
    }

    // MARK: - Styles
    private var glossyBlack: LinearGradient {
        LinearGradient(
            colors: [
                Color.black.opacity(0.95),
                Color.black.opacity(0.75)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Models

private enum Sender {
    case user
    case ai
}

private struct ChatLine: Identifiable, Hashable {
    let id = UUID()
    let sender: Sender
    let text: String

    static func user(_ text: String) -> ChatLine { .init(sender: .user, text: text) }
    static func ai(_ text: String) -> ChatLine { .init(sender: .ai, text: text) }
}

private struct QuickAction: Identifiable {
    let id = UUID()
    let title: String
    let icon: String?
    let prompt: String

    static let samples: [QuickAction] = [
        .init(title: "Developers", icon: "building.2.fill", prompt: "Show me top developers in Dubai."),
        .init(title: "Fees", icon: "creditcard.fill", prompt: "What fees should I expect when buying a property?"),
        .init(title: "Availability", icon: "calendar.badge.clock", prompt: "What’s available this week in JVC under AED 1.5M?"),
        .init(title: "Mortgage", icon: "percent", prompt: "Estimate mortgage for AED 1.5M, 25% down, 25 years."),
        .init(title: "Contact Agent", icon: "person.fill.checkmark", prompt: "Connect me with an agent now.")
    ]
}

// MARK: - Chat Bubble

private struct ChatBubble: View {
    let line: ChatLine

    var body: some View {
        HStack {
            if line.sender == .ai {
                bubble
                Spacer(minLength: 40)
            } else {
                Spacer(minLength: 40)
                bubble
            }
        }
    }

    private var bubble: some View {
        Group {
            if line.sender == .user {
                Text(line.text)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .background(
                        LinearGradient(
                            colors: [Color.black.opacity(0.95), Color.black.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
            } else {
                Text(line.text)
                    .font(.subheadline)
                    .foregroundStyle(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.black.opacity(0.05))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.black.opacity(0.08), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
            }
        }
    }
}

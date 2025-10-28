import Foundation

final class ChatGPTService {
    static let shared = ChatGPTService()

    private enum Config {
        static let plistName = "Config"
        static let keyName = "OPENAI_API_KEY_BASE64" // Put your Base64-encoded key under this key in Config.plist
    }

    private(set) var apiKey: String?

    private init() {
        loadApiKeyFromConfig()
    }

    private func loadApiKeyFromConfig() {
        guard let url = Bundle.main.url(forResource: Config.plistName, withExtension: "plist"),
              let dict = NSDictionary(contentsOf: url) else {
            print("❌ Failed to find or read \(Config.plistName).plist in bundle.")
            return
        }

        guard let key64 = dict[Config.keyName] as? String,
              let data = Data(base64Encoded: key64),
              let decoded = String(data: data, encoding: .utf8) else {
            print("❌ Missing or invalid \(Config.keyName) in \(Config.plistName).plist (must be Base64-encoded).")
            return
        }

        self.apiKey = decoded.trimmingCharacters(in: .whitespacesAndNewlines)
        print("✅ API key loaded from \(Config.plistName).plist.")
    }

    // MARK: - Public API

    struct ChatMessageParam: Codable {
        let role: String
        let content: String
    }

    struct ChatRequestBody: Codable {
        let model: String
        let messages: [ChatMessageParam]
        let temperature: Double?
        let max_tokens: Int?
    }

    struct ChatChoice: Codable {
        struct Message: Codable {
            let role: String
            let content: String
        }
        let index: Int
        let message: Message
        let finish_reason: String?
    }

    struct ChatResponseBody: Codable {
        let id: String
        let object: String
        let created: Int
        let model: String
        let choices: [ChatChoice]
    }

    enum ChatError: Error, LocalizedError {
        case missingApiKey
        case invalidResponse
        case emptyReply
        case httpError(Int, String)

        var errorDescription: String? {
            switch self {
            case .missingApiKey:
                return "API key is missing. Check Config.plist and OPENAI_API_KEY_BASE64."
            case .invalidResponse:
                return "Invalid response from server."
            case .emptyReply:
                return "The model returned an empty reply."
            case .httpError(let code, let message):
                return "HTTP \(code): \(message)"
            }
        }
    }

    func sendChat(prompt: String) async throws -> String {
        guard let apiKey = apiKey, !apiKey.isEmpty else {
            throw ChatError.missingApiKey
        }

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let systemPrompt = """
        You are an AI assistant for a Dubai real estate brokerage. Be concise, accurate, and helpful about properties, RERA rules, fees, and mortgages. Use emojis sparingly.
        """

        let body = ChatRequestBody(
            model: "gpt-4o-mini",
            messages: [
                .init(role: "system", content: systemPrompt),
                .init(role: "user", content: prompt)
            ],
            temperature: 0.2,
            max_tokens: 500
        )

        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw ChatError.httpError(http.statusCode, message)
        }

        let decoded = try JSONDecoder().decode(ChatResponseBody.self, from: data)
        guard let content = decoded.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines),
              !content.isEmpty else {
            throw ChatError.emptyReply
        }

        return content
    }
}

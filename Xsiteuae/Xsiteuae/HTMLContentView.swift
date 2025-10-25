import SwiftUI
import WebKit

struct HTMLContentView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let styledHTML = """
        <html><head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <style>
            body { font-family: -apple-system; color: white; background-color: black; font-size: 15px; line-height: 1.6; margin: 0; padding: 0; }
            p { margin: 8px 0; }
            a { color: #4da3ff; }
        </style>
        </head><body>\(html)</body></html>
        """
        uiView.loadHTMLString(styledHTML, baseURL: nil)
    }
}

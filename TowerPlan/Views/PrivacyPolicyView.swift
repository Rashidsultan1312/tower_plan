import SwiftUI
import WebKit

struct PrivacyPolicyView: View {
    private let url = URL(string: "https://pumpfuncult.lol/policy")!

    var body: some View {
        ZStack {
            TP.bgGrad.ignoresSafeArea()
            PrivacyWebView(url: url)
                .clipShape(RoundedRectangle(cornerRadius: TP.radius))
                .padding(.horizontal, 8)
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct PrivacyWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let wv = WKWebView(frame: .zero, configuration: config)
        wv.isOpaque = false
        wv.backgroundColor = .clear
        wv.scrollView.backgroundColor = .clear
        wv.load(URLRequest(url: url))
        return wv
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
  private let url: URL
  private let navigationHelper = WebViewHelper()

  public init(url: URL) {
    self.url = url
  }

  public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
    let webview = WKWebView()
    webview.navigationDelegate = navigationHelper

    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
    webview.load(request)

    return webview
  }

  public func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<WebView>) {
    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
    webview.load(request)
  }
}

final class WebViewHelper: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webview didFinishNavigation")
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webviewDidCommit")
    }

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("didReceiveAuthenticationChallenge")
        completionHandler(.performDefaultHandling, nil)
    }
}

struct WebView_Previews: PreviewProvider {
  static var previews: some View {
    WebView(url: URL(string: "https://google.com")!)
  }
}

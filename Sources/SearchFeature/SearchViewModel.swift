import SwiftUI
import NewsClient

@MainActor
final class SearchViewModel: ObservableObject {

  @Published var results: [NewsArticle] = []

  func search(text: String) async {
    guard !text.isEmpty else { return }
    do {
      async let articles = NewsClient.live.search(query: text)
      results = try await articles
    } catch let e {
      print(e)
    }
  }
}

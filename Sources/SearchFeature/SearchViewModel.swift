import SwiftUI
import NewsClient
import OrderedCollections

private let searchHistoryKey = "searchHistory"

@MainActor
final class SearchViewModel: ObservableObject {

  @Published var results: [NewsArticle] = []
  var histories: [String] {
    return UserDefaults.standard.object(forKey: searchHistoryKey) as? [String] ?? []
  }

  func search(text: String) async {
    guard !text.isEmpty else { return }
    do {
      async let articles = NewsClient.live.search(query: text)
      results = try await articles
      addHistory(text)
    } catch let e {
      print(e)
    }
  }

  private func addHistory(_ query: String) {
    var histories = OrderedSet<String>(histories)
    histories.insert(query, at: 0)
    UserDefaults.standard.set(histories.elements, forKey: searchHistoryKey)
  }
}

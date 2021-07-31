import SwiftUI
import NewsClient

@MainActor
final class HeadlinesViewModel: ObservableObject {

  @Published private(set) var articles: [NewsArticle] = []

  func getArticles() throws {
    Task.init(priority: .default) {
      articles = try await NewsClient.live.getTopHeadlines(query: nil, language: .en)
    }
  }

}

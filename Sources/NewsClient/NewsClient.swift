@_exported import NewsAPI

private let API_KEY = "f32c792c14fc4e90a859cde979d06673"

public class NewsClient {

  private let client: NewsAPI

  public init(apiKey: String) {
    client = NewsAPI(apiKey: apiKey)
  }

  public func getTopHeadlines(query: String? = nil, language: Language) async throws -> [NewsArticle] {
    try await client.getTopHeadlines(sources: [], query: query, category: nil, language: language)
  }

  public func search(query: String) async throws -> [NewsArticle] {
    try await client.search(query: query)
  }

  public func getSources() async throws -> [NewsSource] {
    try await client.getSources()
  }
}

public extension NewsClient {
  static let live = NewsClient(apiKey: API_KEY)
}

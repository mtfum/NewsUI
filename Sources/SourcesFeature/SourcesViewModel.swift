import SwiftUI
import NewsClient

@MainActor
final class SourcesViewModel: ObservableObject {

  @Published private(set) var sources: [NewsSource] = []

  func fetchSources() {
    Task {
      sources = try await NewsClient.live.getSources()
    }
  }
}


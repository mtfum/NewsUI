//
//  File.swift
//  File
//
//  Created by Fumiya Yamanaka on 2021/07/24.
//

import SwiftUI
import NewsClient

@MainActor
final class HeadlinesViewModel: ObservableObject {
  @Published var articles: [NewsArticle] = []

  func getArticles() async throws {
    Task.init(priority: .default) {
      do {
        articles = try await NewsClient.live.getTopHeadlines(query: nil, language: .en)
      } catch let e {
        throw e
      }
    }
  }

}

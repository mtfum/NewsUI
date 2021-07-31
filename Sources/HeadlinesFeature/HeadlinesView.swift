//
//  HeadlinesView.swift
//  HeadlinesView
//
//  Created by Fumiya Yamanaka on 2021/07/17.
//

import SwiftUI
import AppComponent

public struct HeadlinesView: View {

  @StateObject private var viewModel = HeadlinesViewModel()
  @State private var errorMessage: String? = nil

  public init() {}

  public var body: some View {
    NavigationView {
      if let errorMessage = errorMessage {
        Text(errorMessage)
          .fontWeight(.bold)
      } else {
        List(viewModel.articles) { article in
          NavigationLink(
            destination: {
              if let url = article.url {
                WebView(url: url)
              }
            },
            label: { ArticleView(article: article) }
          )
            .listRowSeparator(.hidden)
        }
        .task {
          getArticles()
        }
        .listStyle(.plain)
        .navigationTitle("Headlines")
      }
    }
    .refreshable {
      getArticles()
    }
  }

  private func getArticles() {
    errorMessage = nil
    do {
      try viewModel.getArticles()
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

struct HeadlinesView_Previews: PreviewProvider {
  static var previews: some View {
    HeadlinesView()
  }
}

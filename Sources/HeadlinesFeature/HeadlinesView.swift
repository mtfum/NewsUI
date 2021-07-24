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

  public init() {}

  public var body: some View {
    NavigationView {
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
        try? await viewModel.getArticles()
      }
      .listStyle(.plain)
      .navigationTitle("Headlines")
    }
    .refreshable {
      try? await viewModel.getArticles()
    }
  }
}

struct HeadlinesView_Previews: PreviewProvider {
  static var previews: some View {
    HeadlinesView()
  }
}

//
//  SearchView.swift
//  SearchView
//
//  Created by Fumiya Yamanaka on 2021/07/17.
//

import SwiftUI
import AppComponent

public struct SearchView: View {
  @StateObject private var viewModel = SearchViewModel()
  @State private var query = ""

  public init() {}

  public var body: some View {
    NavigationView {
      List(viewModel.results) { article in
        NavigationLink(
          destination: { if let url = article.url { WebView(url: url) } },
          label: { ArticleView(article: article) }
        )
          .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .navigationTitle("Search")
    }
    .searchable(text: $query, suggestions: {
      ForEach(viewModel.histories, id: \.self) { Text($0).searchCompletion($0) }
    })
    .onSubmit(of: .search) {
      Task {
        await viewModel.search(text: query)
      }
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}

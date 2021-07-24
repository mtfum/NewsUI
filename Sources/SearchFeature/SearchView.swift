//
//  SearchView.swift
//  SearchView
//
//  Created by Fumiya Yamanaka on 2021/07/17.
//

import SwiftUI
import AppComponent

public struct SearchView: View {
  @StateObject var viewModel = SearchViewModel()
  @State var query = ""

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
    .searchable(text: $query)
    .onChange(of: query) { query in
      // TODO: AsyncStream
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

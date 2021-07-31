//
//  SourcesView.swift
//  SourcesView
//
//  Created by Fumiya Yamanaka on 2021/07/17.
//

import SwiftUI
import AppComponent
import NewsAPI

public struct SourcesView: View {

  @StateObject private var viewModel = SourcesViewModel()
  @State private var queryString = ""

  private var filteredSources: [NewsSource] {
    if queryString.isEmpty {
      return viewModel.sources
    } else {
      return viewModel.sources.filter { $0.name.localizedCaseInsensitiveContains(queryString) }
    }
  }

  public init() {}

  public var body: some View {
    NavigationView {
      List(filteredSources) { source in
        NavigationLink(
          destination: { if let url = source.url { WebView(url: url) } },
          label: { Text(source.name) }
        )
      }
      .navigationTitle("Sources")
    }
    .searchable(text: $queryString, prompt: "Filter Sources")
    .task {
      viewModel.fetchSources()
    }
  }
}

struct SourcesView_Previews: PreviewProvider {
  static var previews: some View {
    SourcesView()
  }
}

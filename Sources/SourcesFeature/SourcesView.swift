//
//  SourcesView.swift
//  SourcesView
//
//  Created by Fumiya Yamanaka on 2021/07/17.
//

import SwiftUI
import AppComponent

public struct SourcesView: View {

  @StateObject private var viewModel = SourcesViewModel()

  public init() {}

  public var body: some View {
    NavigationView {
      List(viewModel.sources) { source in
        NavigationLink(
          destination: { if let url = source.url { WebView(url: url) } },
          label: { SourceView(source: source) }
        )
      }
      .listStyle(.plain)
      .navigationTitle("Sources")
    }
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

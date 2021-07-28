import SwiftUI
import NewsClient

struct SourceView: View {
  let source: NewsSource
  var body: some View {
    VStack(alignment: .leading) {
      Text(source.name)
        .fontWeight(.bold)
      if let description = source.description {
        Text(description)
          .foregroundColor(.secondary)
      }
      if let category = source.category {
        Text("category: " + category.rawValue)
      }
    }
  }
}

struct SourceView_Previews: PreviewProvider {
  static var previews: some View {
    SourceView(source: NewsSource.demo)
  }
}

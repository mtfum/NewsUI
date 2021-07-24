import SwiftUI
import NewsAPI

public struct ArticleView: View {
  public let article: NewsArticle

  public init(article: NewsArticle) {
    self.article = article
  }

  public var body: some View {
    HStack {
      AsyncImage(url: article.urlToImage) { phase in
        switch phase {
        case .empty:
          ProgressView()
        case .success(let image):
          image.resizable()
            .aspectRatio(1.5, contentMode: .fit)
            .frame(maxWidth: 150)
        case .failure:
          VStack {
            Image(systemName: "square.slash")
            Text("Image is not found")
              .fontWeight(.light)
              .foregroundColor(.secondary)
          }
          .frame(width: 150)
        @unknown default:
          EmptyView()
        }
      }
      Text(article.title ?? "")
        .fontWeight(.bold)
    }
  }
}

struct ArticleView_Previews: PreviewProvider {
  static var previews: some View {
    ArticleView(article: NewsArticle.demo)
  }
}

import Foundation

final class NewsViewModel: ObservableObject {
    @Published var items: [NewsItem] = MockData.news
    @Published var selectedCategory: NewsCategory? = nil
    
    var filteredNews: [NewsItem] {
        if let category = selectedCategory {
            return items.filter { $0.category == category }
        } else {
            return items
        }
    }
}

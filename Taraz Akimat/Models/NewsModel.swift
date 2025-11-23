import Foundation

enum NewsCategory: String, CaseIterable, Identifiable {
    case important = "Важное"
    case housing   = "ЖКХ"
    case youth     = "Молодёжь"
    case business  = "Бизнес"
    
    var id: String { rawValue }
}

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let category: NewsCategory
    let summary: String
    let body: String
    let date: Date
    let imageName: String
}

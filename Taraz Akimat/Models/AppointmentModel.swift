import Foundation

enum Department: String, CaseIterable, Identifiable {
    case housing    = "Отдел ЖКХ"
    case social     = "Соц. защита"
    case education  = "Образование"
    case youth      = "Молодёжная политика"
    case business   = "Бизнес и инвестиции"
    
    var id: String { rawValue }
}

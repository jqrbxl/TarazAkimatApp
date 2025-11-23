import Foundation

enum RequestCategory: String, CaseIterable, Identifiable {
    case roads   = "Дороги"
    case trash   = "Мусор"
    case lights  = "Освещение"
    case parking = "Парковка"
    case other   = "Другое"
    
    var id: String { rawValue }
}

enum RequestStatus: String {
    case received   = "Принято"
    case inProgress = "В работе"
    case done       = "Выполнено"
}

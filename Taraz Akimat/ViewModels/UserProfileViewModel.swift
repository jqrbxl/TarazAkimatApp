import Foundation

final class UserProfileViewModel: ObservableObject {
    @Published var name: String
    @Published var phone: String
    
    private let nameKey = "user_name"
    private let phoneKey = "user_phone"
    
    init() {
        let defaults = UserDefaults.standard
        self.name = defaults.string(forKey: nameKey) ?? "Имя пользователя"
        self.phone = defaults.string(forKey: phoneKey) ?? "+7 *** *** ** **"
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: nameKey)
        defaults.set(phone, forKey: phoneKey)
    }
}

import SwiftUI

class LanguageManager: ObservableObject {
    @AppStorage("selectedLanguage") var selectedLanguage: String = "ru" {
        didSet {
            Bundle.setLanguage(selectedLanguage)
            objectWillChange.send()
        }
    }
}

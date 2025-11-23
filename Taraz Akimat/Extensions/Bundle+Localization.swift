import Foundation
import ObjectiveC

private var bundleKey: UInt8 = 0

// Наследуемся от Bundle и ЯВНО повторяем @unchecked Sendable,
// как того требует Swift 6
final class LanguageBundle: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        // Пробуем взять привязанный путь к нужному .lproj
        if let path = objc_getAssociatedObject(self, &bundleKey) as? String,
           let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key,
                                          value: value,
                                          table: tableName)
        }
        
        // Если ничего не привязано — обычное поведение
        return super.localizedString(forKey: key,
                                     value: value,
                                     table: tableName)
    }
}

extension Bundle {
    static func setLanguage(_ lang: String) {
        // Подменяем класс Bundle.main на свой сабкласс
        object_setClass(Bundle.main, LanguageBundle.self)
        
        // Находим путь к нужной локали
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        
        // Привязываем путь к Bundle.main через objc runtime
        objc_setAssociatedObject(
            Bundle.main,
            &bundleKey,
            path,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
}

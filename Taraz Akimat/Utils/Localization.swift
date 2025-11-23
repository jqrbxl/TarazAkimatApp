import Foundation

extension String {
    var loc: String {
        NSLocalizedString(self, comment: "")
    }
}

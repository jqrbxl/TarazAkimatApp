import SwiftUI

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.vertical, 6)
                .padding(.horizontal, 14)
                .background(isSelected
                            ? Color.appAccent.opacity(0.15)
                            : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.appAccent : Color.gray.opacity(0.4), lineWidth: 1)
                )
                .cornerRadius(12)
                .foregroundColor(isSelected ? .appAccent : .primary)
        }
    }
}

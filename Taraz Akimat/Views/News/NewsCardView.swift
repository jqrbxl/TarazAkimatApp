import SwiftUI

struct NewsCardView: View {
    let item: NewsItem
    
    var body: some View {
        VStack(spacing: 0) {
            
            // --- ВСЕГДА ОДНА ВЫСОТА КАРТИНКИ ---
            ZStack {
                if !item.imageName.isEmpty {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                } else {
                    // Плейсхолдер, если нет картинки
                    Color.gray.opacity(0.15)
                        .frame(height: 180)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.gray.opacity(0.5))
                        )
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
            
            // --- ТЕКСТОВАЯ ЧАСТЬ ---
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(item.category.rawValue)
                        .font(.caption)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.accentColor.opacity(0.15))
                        .foregroundColor(.accentColor)
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    Text(item.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(item.title)
                    .font(.headline.bold())
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Text(item.summary)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Text("Подробнее")
                        .font(.footnote.weight(.medium))
                        .foregroundColor(.accentColor)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.accentColor)
                }
                .padding(.top, 4)
            }
            .padding(14)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
    }
}

import SwiftUI

struct NewsDetailView: View {
    let item: NewsItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // КАРТИНКА
                if !item.imageName.isEmpty {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)   // ширина по экрану
                        .frame(height: 220)           // фикс высота
                        .clipped()                    // обрезаем лишнее
                        .cornerRadius(18)
                        .shadow(color: .black.opacity(0.08),
                                radius: 10, x: 0, y: 4)
                }
                
                // КОНТЕНТ КАРТОЧКИ
                VStack(alignment: .leading, spacing: 12) {
                    
                    // Категория + дата
                    HStack {
                        Text(item.category.rawValue)
                            .font(.caption.weight(.medium))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.accentColor.opacity(0.12))
                            .foregroundColor(.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8,
                                                        style: .continuous))
                        
                        Spacer()
                        
                        Text(item.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Заголовок
                    Text(item.title)
                        .font(.title3.bold())
                        .multilineTextAlignment(.leading)
                    
                    Divider()
                    
                    // Текст новости
                    Text(item.body)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05),
                                radius: 8, x: 0, y: 3)
                )
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Новость")
        .navigationBarTitleDisplayMode(.inline)
    }
}

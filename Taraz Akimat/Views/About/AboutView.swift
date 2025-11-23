import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("О приложении")
                    .font(.title2.bold())
                
                Text("«Taraz Akimat» — мобильное приложение для жителей города Тараз, разработанное в рамках дипломного проекта.")
                    .font(.body)
                
                Group {
                    Text("Основные функции:")
                        .font(.headline)
                    bullet("Лента новостей акимата города")
                    bullet("Подача электронных заявок и обращений")
                    bullet("Запись на приём в подразделения акимата")
                    bullet("Участие в городских опросах")
                    bullet("Личный кабинет жителя")
                }
                
                Group {
                    Text("Технологический стек:")
                        .font(.headline)
                    bullet("SwiftUI")
                    bullet("Core Data")
                    bullet("UserNotifications (локальные уведомления)")
                    bullet("MapKit / UserDefaults (при необходимости)")
                }
                
                Group {
                    Text("Автор:")
                        .font(.headline)
                    Text("Zharbol Ermagambet\nСтудент Международного университета информационных технологий (МУИТ).")
                }
                
                Group {
                    Text("Версия приложения:")
                        .font(.headline)
                    Text("1.0 (демо-версия для дипломного проекта)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("О приложении")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
            Text(text)
        }
        .font(.body)
    }
}

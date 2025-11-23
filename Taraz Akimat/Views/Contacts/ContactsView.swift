import SwiftUI

struct ContactsView: View {
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        List {
            Section("Акимат города Тараз") {
                contactRow(
                    title: "Приёмная акима",
                    phone: "+7 7262 43 33 00",
                    address: "пр. Төле би, 55"
                )
            }
            
            Section("Службы города") {
                contactRow(title: "Единый контакт-центр", phone: "109", address: "Городские обращения")
                contactRow(title: "Полиция", phone: "102", address: "Экстренная служба")
                contactRow(title: "Скорая помощь", phone: "103", address: "Экстренная служба")
                contactRow(title: "Пожарная служба", phone: "101", address: "Экстренная служба")
            }
        }
        .navigationTitle("Контакты города")
    }
    
    private func contactRow(title: String, phone: String, address: String) -> some View {
        Button {
            if let url = URL(string: "tel://\(phone.filter { $0.isNumber })") {
                openURL(url)
            }
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.body)
                    Text(address)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(phone)
                        .font(.caption2)
                        .foregroundColor(.blue)
                }
                Spacer()
                Image(systemName: "phone.fill")
                    .foregroundColor(.green)
            }
            .padding(.vertical, 6)
        }
    }
}

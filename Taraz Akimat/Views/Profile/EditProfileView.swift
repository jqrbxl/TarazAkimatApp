import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UserProfileViewModel
    
    @State private var tempName: String = ""
    @State private var tempPhone: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Личные данные") {
                    TextField("Имя", text: $tempName)
                    
                    TextField("Номер телефона", text: $tempPhone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Редактировать профиль")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        viewModel.name = tempName
                        viewModel.phone = tempPhone
                        viewModel.save()
                        dismiss()
                    }
                }
            }
            .onAppear {
                tempName = viewModel.name
                tempPhone = viewModel.phone
            }
        }
    }
}

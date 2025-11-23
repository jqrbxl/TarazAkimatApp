import SwiftUI

struct NewRequestView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: RequestsViewModel
    
    @State private var selectedCategory: RequestCategory = .roads
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Категория", selection: $selectedCategory) {
                    ForEach(RequestCategory.allCases) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
                
                TextField("Краткое название проблемы", text: $title)
                
                Section("Описание") {
                    TextEditor(text: $description)
                        .frame(minHeight: 120)
                }
            }
            .navigationTitle("Новая заявка")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Отправить") {
                        guard !title.isEmpty, !description.isEmpty else { return }
                        viewModel.addRequest(
                            category: selectedCategory,
                            title: title,
                            description: description
                        )
                        dismiss()
                    }
                }
            }
        }
    }
}

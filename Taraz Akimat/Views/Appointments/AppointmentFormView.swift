import SwiftUI

struct AppointmentFormView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AppointmentsViewModel
    
    @State private var selectedDepartment: Department = .housing
    @State private var selectedDate: Date = Date().addingTimeInterval(3600 * 24)
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Отдел", selection: $selectedDepartment) {
                    ForEach(Department.allCases) { dept in
                        Text(dept.rawValue).tag(dept)
                    }
                }
                
                DatePicker("Дата и время",
                           selection: $selectedDate,
                           in: Date()...,
                           displayedComponents: [.date, .hourAndMinute])
            }
            .navigationTitle("Новая запись")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Подтвердить") {
                        viewModel.book(department: selectedDepartment,
                                       date: selectedDate)
                        dismiss()
                    }
                }
            }
        }
    }
}

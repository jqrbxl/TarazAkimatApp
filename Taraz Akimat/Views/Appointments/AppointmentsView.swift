import SwiftUI

struct AppointmentsView: View {
    @StateObject private var viewModel = AppointmentsViewModel()
    @State private var showingForm = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Мои записи") {
                        ForEach(viewModel.appointments) { appt in
                            VStack(alignment: .leading) {
                                Text(appt.department ?? "")
                                    .font(.headline)
                                
                                if let date = appt.date {
                                    Text(date, style: .date)
                                        .font(.subheadline)
                                    Text(date, style: .time)
                                        .font(.subheadline)
                                }
                                
                                Text("Талон: \(appt.ticketNumber ?? "")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.delete(appt)
                                } label: {
                                    Label("Удалить", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                
                Button("Записаться на приём") {
                    showingForm = true
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Запись на приём")
            .sheet(isPresented: $showingForm) {
                AppointmentFormView(viewModel: viewModel)
            }
        }
    }
}

import Foundation

final class AppointmentsViewModel: ObservableObject {
    @Published var appointments: [AppointmentEntity] = []
    
    private let manager = CoreDataManager.shared
    
    init() {
        loadAppointments()
    }
    
    func loadAppointments() {
        do {
            appointments = try manager.fetchAppointments()
        } catch {
            print("Error fetching appointments: \(error)")
        }
    }
    
    func book(department: Department, date: Date) {
        let ticket = "T-\(Int.random(in: 100...999))"
        do {
            try manager.addAppointment(
                department: department.rawValue,
                date: date,
                ticketNumber: ticket
            )
            loadAppointments()
            
            // 🔔 уведомление
            NotificationManager.shared.scheduleAppointmentNotification(
                date: date,
                department: department.rawValue
            )
        } catch {
            print("Error adding appointment: \(error)")
        }
    }
    func delete(_ appointment: AppointmentEntity) {
            do {
                try manager.deleteAppointment(appointment)
                loadAppointments()
            } catch {
                print("Error deleting appointment: \(error)")
            }
        }
    
}


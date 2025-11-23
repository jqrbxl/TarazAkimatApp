import Foundation

final class ProfileStatsViewModel: ObservableObject {
    @Published var requestsCount: Int = 0
    @Published var appointmentsCount: Int = 0
    @Published var pollsCount: Int = 0
    
    private let manager = CoreDataManager.shared
    
    func refresh() {
        do {
            let requests = try manager.fetchRequests()
            let appointments = try manager.fetchAppointments()
            let polls = try manager.fetchPolls()
            
            requestsCount = requests.count
            appointmentsCount = appointments.count
            pollsCount = polls.count
        } catch {
            print("Error loading profile stats: \(error)")
        }
    }
}

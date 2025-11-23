import Foundation

final class RequestsViewModel: ObservableObject {
    @Published var myRequests: [RequestEntity] = []
    
    private let manager = CoreDataManager.shared
    
    init() {
        loadRequests()
    }
    
    func loadRequests() {
        do {
            myRequests = try manager.fetchRequests()
        } catch {
            print("Error fetching requests: \(error)")
        }
    }
    
    func addRequest(category: RequestCategory,
                    title: String,
                    description: String) {
        do {
            try manager.addRequest(
                category: category.rawValue,
                title: title,
                detailText: description
            )
            loadRequests()
            
            // 🔔 уведомление
            NotificationManager.shared.scheduleRequestCreatedNotification(title: title)
        } catch {
            print("Error adding request: \(error)")
        }
    }
    
    func updateStatus(request: RequestEntity, to status: RequestStatus) {
        do {
            try manager.updateRequestStatus(request, to: status.rawValue)
            loadRequests()
        } catch {
            print("Error updating status: \(error)")
        }
    }
    
    func delete(_ request: RequestEntity) {
            do {
                try manager.deleteRequest(request)
                loadRequests()
            } catch {
                print("Error deleting request: \(error)")
            }
        }
}

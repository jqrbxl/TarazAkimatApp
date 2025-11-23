import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context: NSManagedObjectContext
    
    private init() {
        context = PersistenceController.shared.container.viewContext
    }
    
    // MARK: - Requests
    
    func fetchRequests() throws -> [RequestEntity] {
        let request: NSFetchRequest<RequestEntity> = RequestEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        return try context.fetch(request)
    }
    
    func addRequest(category: String,
                    title: String,
                    detailText: String,
                    status: String = "Принято") throws {
        let entity = RequestEntity(context: context)
        entity.id = UUID()
        entity.category = category
        entity.title = title
        entity.detailText = detailText
        entity.status = status
        entity.createdAt = Date()
        try save()
    }
    
    func updateRequestStatus(_ request: RequestEntity, to newStatus: String) throws {
        request.status = newStatus
        try save()
    }
    
    /// 🔥 Удаление заявки
    func deleteRequest(_ request: RequestEntity) throws {
        context.delete(request)
        try save()
    }
    
    // MARK: - Appointments
    
    func fetchAppointments() throws -> [AppointmentEntity] {
        let request: NSFetchRequest<AppointmentEntity> = AppointmentEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return try context.fetch(request)
    }
    
    func addAppointment(department: String,
                        date: Date,
                        ticketNumber: String) throws {
        let entity = AppointmentEntity(context: context)
        entity.id = UUID()
        entity.department = department
        entity.date = date
        entity.ticketNumber = ticketNumber
        try save()
    }
    
    /// 🔥 Удаление записи на приём
    func deleteAppointment(_ appointment: AppointmentEntity) throws {
        context.delete(appointment)
        try save()
    }
    
    // MARK: - Polls
    
    func fetchPolls() throws -> [PollEntity] {
        let request: NSFetchRequest<PollEntity> = PollEntity.fetchRequest()
        return try context.fetch(request)
    }
    
    func addPoll(question: String,
                 options: [String],
                 votes: [Int]) throws {
        let entity = PollEntity(context: context)
        entity.id = UUID()
        entity.question = question
        entity.optionsData = try PollCoder.encodeOptions(options)
        entity.votesData = try PollCoder.encodeVotes(votes)
        try save()
    }
    
    func updatePollVotes(_ poll: PollEntity, votes: [Int]) throws {
        poll.votesData = try PollCoder.encodeVotes(votes)
        try save()
    }
    
    // MARK: - Save
    
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}

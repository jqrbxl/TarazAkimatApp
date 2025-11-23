import Foundation

final class PollsViewModel: ObservableObject {
    @Published var polls: [PollEntity] = []
    
    private let manager = CoreDataManager.shared
    
    init() {
        loadPolls()
        if polls.isEmpty {
            seedPollsIfNeeded()
        }
    }
    
    func loadPolls() {
        do {
            polls = try manager.fetchPolls()
        } catch {
            print("Error fetching polls: \(error)")
        }
    }
    
    private func seedPollsIfNeeded() {
        do {
            try manager.addPoll(
                question: "Что важнее в вашем районе?",
                options: ["Освещение", "Уборка мусора", "Детская площадка"],
                votes: [10, 5, 3]
            )
            try manager.addPoll(
                question: "Как часто вы готовы участвовать в опросах?",
                options: ["Раз в месяц", "Раз в квартал", "Раз в год"],
                votes: [7, 2, 1]
            )
            loadPolls()
        } catch {
            print("Error seeding polls: \(error)")
        }
    }
    
    func decodePoll(_ poll: PollEntity) -> PollViewModelStruct {
        let options = PollCoder.decodeOptions(poll.optionsData)
        let votes   = PollCoder.decodeVotes(poll.votesData)
        return PollViewModelStruct(
            id: poll.id ?? UUID(),
            question: poll.question ?? "",
            options: options,
            votes: votes
        )
    }
    
    func vote(poll: PollEntity, optionIndex: Int) {
        var votes = PollCoder.decodeVotes(poll.votesData)
        guard optionIndex < votes.count else { return }
        votes[optionIndex] += 1
        
        do {
            try manager.updatePollVotes(poll, votes: votes)
            loadPolls()
        } catch {
            print("Error updating poll votes: \(error)")
        }
    }
}

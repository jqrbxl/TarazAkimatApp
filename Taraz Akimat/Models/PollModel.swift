import Foundation

struct PollViewModelStruct: Identifiable {
    let id: UUID
    let question: String
    let options: [String]
    let votes: [Int]
}

enum PollCoder {
    static func encodeOptions(_ options: [String]) throws -> Data {
        try JSONEncoder().encode(options)
    }
    
    static func decodeOptions(_ data: Data?) -> [String] {
        guard let data else { return [] }
        return (try? JSONDecoder().decode([String].self, from: data)) ?? []
    }
    
    static func encodeVotes(_ votes: [Int]) throws -> Data {
        try JSONEncoder().encode(votes)
    }
    
    static func decodeVotes(_ data: Data?) -> [Int] {
        guard let data else { return [] }
        return (try? JSONDecoder().decode([Int].self, from: data)) ?? []
    }
}

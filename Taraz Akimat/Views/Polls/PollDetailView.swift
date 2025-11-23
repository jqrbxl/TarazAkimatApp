import SwiftUI

struct PollDetailView: View {
    let pollEntity: PollEntity
    let poll: PollViewModelStruct
    @ObservedObject var viewModel: PollsViewModel
    
    private var totalVotes: Int {
        poll.votes.reduce(0, +)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(poll.question)
                .font(.title3.bold())
            
            ForEach(poll.options.indices, id: \.self) { index in
                let option = poll.options[index]
                let votes = poll.votes[index]
                let percent = totalVotes > 0
                ? Int((Double(votes) / Double(totalVotes)) * 100)
                : 0
                
                Button {
                    viewModel.vote(poll: pollEntity, optionIndex: index)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(option)
                            Text("\(votes) голос(ов) • \(percent)%")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Опрос")
        .navigationBarTitleDisplayMode(.inline)
    }
}

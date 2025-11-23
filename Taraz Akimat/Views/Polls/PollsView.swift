import SwiftUI

struct PollsView: View {
    @StateObject private var viewModel = PollsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.polls) { pollEntity in
                    let poll = viewModel.decodePoll(pollEntity)
                    NavigationLink {
                        PollDetailView(pollEntity: pollEntity,
                                       poll: poll,
                                       viewModel: viewModel)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(poll.question)
                                .font(.headline)
                            Text("Вариантов: \(poll.options.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Опросы")
        }
    }
}

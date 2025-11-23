import SwiftUI

struct RequestsView: View {
    @StateObject private var viewModel = RequestsViewModel()
    @State private var showingNewRequest = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.myRequests) { request in
                    NavigationLink {
                        RequestDetailView(request: request, viewModel: viewModel)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(request.title ?? "")
                                .font(.headline)
                            
                            Text(request.category ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Text(request.status ?? "")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                if let date = request.createdAt {
                                    Text(date, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.delete(request)
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Мои заявки")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingNewRequest = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingNewRequest) {
                NewRequestView(viewModel: viewModel)
            }
        }
    }
}

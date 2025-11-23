import SwiftUI

struct RequestDetailView: View {
    let request: RequestEntity
    @ObservedObject var viewModel: RequestsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(request.title ?? "")
                .font(.title2.bold())
            Text("Категория: \(request.category ?? "")")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Статус: \(request.status ?? "")")
                .font(.subheadline)
            
            if let createdAt = request.createdAt {
                Text("Создано: \(createdAt.formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            Text(request.detailText ?? "")
                .font(.body)
            
            Spacer()
            
            HStack {
                Button("Отметить как в работе") {
                    viewModel.updateStatus(request: request, to: .inProgress)
                }
                .buttonStyle(.bordered)
                
                Button("Отметить как выполнено") {
                    viewModel.updateStatus(request: request, to: .done)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .navigationTitle("Заявка")
        .navigationBarTitleDisplayMode(.inline)
    }
}

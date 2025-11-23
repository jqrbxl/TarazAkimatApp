import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                
                VStack(spacing: 12) {
                    
                    // Чипы категорий
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            CategoryChip(title: "Все",
                                         isSelected: viewModel.selectedCategory == nil) {
                                viewModel.selectedCategory = nil
                            }
                            
                            ForEach(NewsCategory.allCases) { category in
                                CategoryChip(title: category.rawValue,
                                             isSelected: viewModel.selectedCategory == category) {
                                    viewModel.selectedCategory = category
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                    
                    // Список новостей
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredNews) { item in
                                NavigationLink {
                                    NewsDetailView(item: item)
                                } label: {
                                    NewsCardView(item: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                }
            }
            .navigationTitle("Новости")
        }
    }
}

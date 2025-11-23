import SwiftUI

struct MainTabView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        TabView {
            NewsListView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Новости")
                }
            
            RequestsView()
                .tabItem {
                    Image(systemName: "exclamationmark.bubble")
                    Text("Заявки")
                }
            
            AppointmentsView()
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("Запись")
                }
            
            PollsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Опросы")
                }
            
            // Профиль / Вход
            Group {
                if isLoggedIn {
                    ProfileView()
                } else {
                    AuthView()   // экран авторизации, который мы уже сделали
                }
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Аккаунт")
            }
        }
    }
}

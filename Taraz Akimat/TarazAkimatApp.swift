import SwiftUI
import UserNotifications

@main
struct TarazAkimatApp: App {
    @StateObject var languageManager = LanguageManager()
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(languageManager)
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
                .onAppear {
                    NotificationManager.shared.requestAuthorization()
                }
        }
    }
    
}

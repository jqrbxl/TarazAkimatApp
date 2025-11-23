import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error {
                print("Notification permission error: \(error)")
            } else {
                print("Notifications granted: \(granted)")
            }
        }
    }
    
    func scheduleAppointmentNotification(date: Date, department: String) {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание о приёме"
        content.body = "У вас запись в отдел: \(department)"
        content.sound = .default
        
        // За 1 час до приёма (если успеваем), иначе — через 10 секунд для демо
        let triggerDate = Calendar.current.date(byAdding: .hour, value: -1, to: date) ?? Date().addingTimeInterval(10)
        let trigger: UNTimeIntervalNotificationTrigger
        
        let interval = max(triggerDate.timeIntervalSinceNow, 10)
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print("Notification error: \(error)")
            }
        }
    }
    
    func scheduleRequestCreatedNotification(title: String) {
        let content = UNMutableNotificationContent()
        content.title = "Заявка отправлена"
        content.body = "Ваша заявка \"\(title)\" успешно принята в работу."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(request)
        }
}

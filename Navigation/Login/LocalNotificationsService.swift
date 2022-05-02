
import Foundation
import UserNotifications
import UIKit

class LocalNotificationsService: NSObject, UNUserNotificationCenterDelegate {
    
    var delegateAlertNotification: AlertNotification?
    
    let center = UNUserNotificationCenter.current()
    
    func registeForLatestUpdatesIfPossible() {
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { (granted, error) in
            if granted {
                self.registerUpdatesCategory()
                self.scheduleNotification()
            } else {
                DispatchQueue.main.async {
                    self.delegateAlertNotification?.showAlertNotification(title: "Уведомления отключены", message: "Хотите включить", url: URL(string: "App-Prefs:root=NOTIFICATIONS_ID"), titleAction: "Настройки")
                }
            }
        }
    }
    
    func scheduleNotification() {
        let pathUrl = createLocalUrl(forImageNamed: "vedmak")!
        let attachment = try! UNNotificationAttachment(identifier: "image", url: pathUrl, options: [:])
    
        let content = UNMutableNotificationContent()
        
        content.title = "Ваша популярность растёт"
        content.body = "Узнайте скольско лайков на публикации"
        
        content.categoryIdentifier = "updates"
        content.sound = .default
        content.badge = 39
        content.attachments = [attachment]
    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requesOfHour = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(requesOfHour)
    }
    
    func createLocalUrl(forImageNamed name: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        
        guard fileManager.fileExists(atPath: url.path) else {
            guard
                let image = UIImage(named: name),
                let data = image.pngData()
            else { return nil }
            
            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }
        return url
    }
    
    func registerUpdatesCategory() {
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "Показать пост", title: "Показать пост", options: .foreground)
        let category = UNNotificationCategory(identifier: "updates", actions: [show], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // пользователь сделал свайп
            print("Default Identifier")
        case "Показать":
            print("Переход на пост")
        default:
            break
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

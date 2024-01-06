//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Kr Qqq on 22.12.2023.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    
    func registeForLatestUpdatesIfPossible() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(error)
                return
            }
            if granted {
                self.registerCategory()
                self.addNotification(title: NSLocalizedString("Updates", comment: ""), text: NSLocalizedString("Look last updates", comment: ""), hour: 23, minute: 34)
            }
        }
    }
    
    func addNotification(title: String, text: String, hour: Int, minute: Int = 0) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = .default
        content.categoryIdentifier = "sheduler"
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func registerCategory() {
        let action = UNNotificationAction(identifier: "newPost", title: NSLocalizedString("New post", comment: ""), options: [])
        let category = UNNotificationCategory(identifier: "sheduler", actions: [action], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}

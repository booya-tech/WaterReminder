//
//  NotificationManager.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 1/16/24.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    
    static let instance = NotificationManager() // Singleton
    
    func requestAutorization() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                print("The user's authorization was succeeded")
            }
        }
        
    }
    
    func scheduleNotification() {
        
        // Content of notification's pop-up
        let content = UNMutableNotificationContent()
        content.title = "Remind me to drink a water (every hour)"
        content.subtitle = "You're thirsty! Let's drink some water."
        content.sound = .default
        
        // Trigger every 3600 seconds or 1 hour
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600.0, repeats: true)
        
        // Create Request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
}

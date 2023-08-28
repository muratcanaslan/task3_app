//
//  AppDelegate.swift
//  task3_app
//
//  Created by Murat Can ASLAN on 29.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = HomeViewController()
        return true
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleLocalNotification(remainingTime: TimerManager.shared.remainingTime)
    }
    
    func scheduleLocalNotification(remainingTime: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Wake Up!"
        content.body = "Last remaining time before you killed app: \(remainingTime) seconds"
        if let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundURL.lastPathComponent))
        } else {
            content.sound = UNNotificationSound.default
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: remainingTime, repeats: false)
        let request = UNNotificationRequest(identifier: "timerNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}




//
//  HomeViewModel.swift
//  task3_app
//
//  Created by Murat Can ASLAN on 29.08.2023.
//

import Foundation
import UserNotifications

final class HomeViewModel {
    
    var grantedNotif: Bool = false
    
    func requestNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            self.grantedNotif = ((error == nil) && granted)
        }
    }
}

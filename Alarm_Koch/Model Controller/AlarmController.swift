//
//  AlarmController.swift
//  Alarm_Koch
//
//  Created by Dustin Koch on 5/6/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController: AlarmScheduler {
    
    private init(){
        self.alarms = loadFromPersistence()
    }
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    //MARK: - Mock alarm data
    var mockAlarms: [Alarm] = {
        let firstAlarm = Alarm(fireDate: Date(), name: "Time to wake up")
        let secondAlarm = Alarm(fireDate: Date(), name: "Workout, brah 🙆🏼‍♂️")
        let thirdAlarm = Alarm(fireDate: Date(), name: "Bedtime")
        return [firstAlarm, secondAlarm, thirdAlarm]
    }()
    
    //MARK: - CRUD Functions
    @discardableResult
    func addAlarm(fireDate: Date, name: String, enabled: Bool = true) -> Alarm {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        saveToPersistence()
        scheduleUserNotifications(alarm: newAlarm)
        return newAlarm
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String) {
        cancelUserNotifications(alarm: alarm)
        alarm.fireDate = fireDate
        alarm.name = name
        saveToPersistence()
        scheduleUserNotifications(alarm: alarm)
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistence()
        cancelUserNotifications(alarm: alarm)
        
    }
    
    func switchFlipped(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistence()
        
    }

    //Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "alarms.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        
        return fullURL
    }
    
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileURL())
        } catch  {
            print("👻 \(error)")
        }
    }
    
    func loadFromPersistence() -> [Alarm] {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let encodedData = try jsonDecoder.decode([Alarm].self, from: data)
            return encodedData
        } catch  {
            print("👿 error")
        }
        return []
    }
} // end of alarm controller class


//MARK: - Notifications
protocol AlarmScheduler {
    func scheduleUserNotifications(alarm: Alarm)
    func cancelUserNotifications(alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(alarm: Alarm) {
        //set up request
        let content = UNMutableNotificationContent()
        content.title = "🔔 ‼️ ⏰ ‼️ 🔔"
        content.body = "Your alarm \(alarm.name)is going off!"
        let date = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        //add request
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Oh snap! Unable to schedule local notification: \(error) : \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotifications(alarm: Alarm) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [alarm.uuid])
    }

} // end of extension

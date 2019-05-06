//
//  AlarmController.swift
//  Alarm_Koch
//
//  Created by Dustin Koch on 5/6/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

class AlarmController {
    
    private init(){
        self.alarms = self.mockAlarms
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
    func addAlarm(fireDate: Date, name: String) -> Alarm {
        let newAlarm = Alarm(fireDate: fireDate, name: name)
        alarms.append(newAlarm)
        return newAlarm
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String) {
        alarm.fireDate = fireDate
        alarm.name = name
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
    func switchFlipped(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
}

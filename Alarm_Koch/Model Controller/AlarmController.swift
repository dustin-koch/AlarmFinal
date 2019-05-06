//
//  AlarmController.swift
//  Alarm_Koch
//
//  Created by Dustin Koch on 5/6/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
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
}

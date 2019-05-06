//
//  SwitchTableViewCell.swift
//  Alarm_Koch
//
//  Created by Dustin Koch on 5/6/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    var alarm: Alarm? {
        didSet{
            updateCellView()
        }
    }
    weak var delegate: SwitchTableViewCellDelegate?

    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    @IBAction func alarmSwitchTapped(_ sender: UISwitch) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    func updateCellView(){
        guard let alarm = alarm else { return }
        alarmTimeLabel.text = alarm.fireTimeAsString
        alarmNameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }

}// End of Class

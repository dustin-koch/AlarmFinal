//
//  AlarmDetailTableViewController.swift
//  Alarm_Koch
//
//  Created by Dustin Koch on 5/6/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: - Outlets
    @IBOutlet weak var datePIcker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var saveButtonTitle: UIButton!
    
    //MARK - Properties
    var alarm: Alarm? {
        didSet {
            alarmIsOn = alarm?.enabled ?? false
            loadViewIfNeeded()
            updateViews(alarm: alarm)
        }
    }
    var alarmIsOn: Bool = true
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else { return }
        AlarmController.shared.switchFlipped(alarm: alarm)
        updateViews(alarm: alarm)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let alarm = alarm {
            guard let name = alarmNameTextField.text, alarmNameTextField.text != nil else { return }
            AlarmController.shared.updateAlarm(alarm: alarm, fireDate: datePIcker.date, name: name)
        } else {
            AlarmController.shared.addAlarm(fireDate: datePIcker.date, name: alarmNameTextField.text!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews(alarm: Alarm?){
        guard let unwrappedAlarm = alarm else { return }
        alarmNameTextField.text = unwrappedAlarm.name
        datePIcker.date = unwrappedAlarm.fireDate
        if unwrappedAlarm.enabled == true {
            saveButtonTitle.setTitle("Alarm is On", for: .normal)
            saveButtonTitle.backgroundColor = .green
        } else {
            saveButtonTitle.setTitle("Alarm is Off", for: .disabled)
            saveButtonTitle.backgroundColor = .red
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}

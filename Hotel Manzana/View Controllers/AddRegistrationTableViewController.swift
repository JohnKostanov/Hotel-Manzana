//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by  Джон Костанов on 06/08/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet var roomTypeLabel: UILabel!
    
    // MARK: - Properties
    let checkInDateLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDateLabelIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    var roomType: RoomType?
    var guest = Guest()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        updateDoneBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDoneBarButton()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SelectRoomType" else { return }
        let destination = segue.destination as! SelectRoomTypeTableViewController
        destination.delagate = self
        destination.roomType = roomType
        
        saveNewGuest()
    }
    
    // MARK: - UI Methods
    func saveNewGuest() {
        guest.firstName = firstNameTextField.text!
        guest.lastName = lastNameTextField.text!
        guest.email = emailTextField.text!
        guest.periodOfResidencia = "\(checkInDateLabel.text!) - \(checkOutDateLabel.text!)"
        guest.roomType = roomTypeLabel.text!
    }
    
    func updateDoneBarButton() {
        guard let textFirstName = firstNameTextField.text else { return }
        guard let textLastName = lastNameTextField.text else { return }
        guard let textEmail = emailTextField.text else { return }
        if textFirstName.isEmpty || textLastName.isEmpty || textEmail.isEmpty || roomTypeLabel.text == "Non Set" {
            doneBarButtonItem.isEnabled = false
        } else {
            doneBarButtonItem.isEnabled = true
        }
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuests() {
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        numberOfAdultsLabel.text = "\(numberOfAdults)"
        numberOfChildrenLabel.text = "\(numberOfChildren)"
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
            guest.roomType = roomTypeLabel.text!
        } else {
            roomTypeLabel.text = "Non Set"
        }
    }
    
    // MARK: - Actions
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func firstNameLastNameEmailTextField(_ sender: UITextField) {
        updateDoneBarButton()
    }
    
}
// MARK: - UITableViewDataSource
extension AddRegistrationTableViewController /*: UITableViewDataSource */ {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath:
            return isCheckInDatePickerShown ? UITableView.automaticDimension : 0
        case checkOutDatePickerIndexPath:
            return isCheckOutDatePickerShown ?  UITableView.automaticDimension : 0
        default:
            return UITableView.automaticDimension
        }
    }
}
// MARK: - UITableViewDelegate
extension AddRegistrationTableViewController/*: UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case checkInDateLabelIndexPath:
            isCheckInDatePickerShown.toggle()
            isCheckOutDatePickerShown = false
        case checkOutDateLabelIndexPath:
            isCheckOutDatePickerShown.toggle()
            isCheckInDatePickerShown = false
        default:
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
// MARK: - SelectRoomTypeTableViewControllerProtocol
extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerProtocol {
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    
}

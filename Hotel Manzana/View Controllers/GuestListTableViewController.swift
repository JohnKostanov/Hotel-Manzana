//
//  GuestListTableViewController.swift
//  Hotel Manzana
//
//  Created by  Джон Костанов on 07/08/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//

import UIKit

class GuestListTableViewController: UITableViewController {
    
    let cellManager = CellManager()
    var guestList: [Guest]!

    override func viewDidLoad() {
        guestList = Guest.loadDefaullts()
    }
}
// MARK: - UITableViewDataSource
extension GuestListTableViewController/*: UITableViewDataSource*/ {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guest = guestList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestListCell")! as! GuestCell
        
        cellManager.configure(cell, with: guest)
        return cell
        
    }
}

// MARK: Actions
extension GuestListTableViewController {
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        
        let source = segue.source as! AddRegistrationTableViewController
        let guest = source.guest
        print(guest)
        
        let indexPath = IndexPath(row: guestList.count, section: 0)
        guestList.append(guest)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
}

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
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedGuest = guestList.remove(at: sourceIndexPath.row)
        guestList.insert(movedGuest, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none:
            break
        case .delete:
            guestList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            break
        default :
            print(#line, #function, "Unknown case in file \(#file)")
            break
        }
    }
}

//MARK: - UITableViewDelegate
extension GuestListTableViewController /*: UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
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

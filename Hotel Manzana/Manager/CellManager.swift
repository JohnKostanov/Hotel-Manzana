//
//  CellManager.swift
//  Hotel Manzana
//
//  Created by  Джон Костанов on 07/08/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//

import UIKit

class CellManager {
    func configure(_ cell: GuestCell, with guest: Guest) {
        cell.firstNameLabel.text = guest.firstName
        cell.lastNameLabel.text = guest.lastName
        cell.emalLabel.text = guest.email
        cell.periodOfResidencia.text = guest.periodOfResidencia
        cell.roomTypeLabel.text = guest.roomType
    }
}

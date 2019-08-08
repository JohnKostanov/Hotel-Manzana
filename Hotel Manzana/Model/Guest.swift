//
//  Guest.swift
//  Hotel Manzana
//
//  Created by  Джон Костанов on 07/08/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//

import Foundation

struct Guest: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var periodOfResidencia: String
    var roomType: String
    
    init(firstName: String = "", lastName: String = "", email: String = "", periodOfResidencia: String = "", roomType: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.periodOfResidencia = periodOfResidencia
        self.roomType = roomType
    }
}

extension Guest {
    static var all: [Guest] {
        return [
        Guest(firstName: "John", lastName: "Kostanov", email: "kostanovd@icloud.com", periodOfResidencia: "10.08.19 - 12.08.19", roomType: "Penthouse"),
        Guest(firstName: "Ivan", lastName: "Ivanov", email: "ivanov@icloud.com", periodOfResidencia: "14.08.19 - 18.08.19", roomType: "One King")
        ]
    }
    
    static func loadDefaullts() -> [Guest] {
        return all
    }
}


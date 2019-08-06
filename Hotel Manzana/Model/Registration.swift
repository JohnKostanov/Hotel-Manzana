//
//  Registration.swift
//  Hotel Manzana
//
//  Created by  Джон Костанов on 06/08/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAdress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

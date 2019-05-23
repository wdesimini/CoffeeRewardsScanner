//
//  User.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/14/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


class User {
    var firstName: String
    var lastName: String
    var imageString: String?
    
    init(firstName: String, lastName: String, imageString: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageString = imageString
    }
    
    var card: Card?
}

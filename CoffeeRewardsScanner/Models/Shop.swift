//
//  Shop.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/16/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


struct Shop {
    let name: String
    let logoImageString: String
    let cupImageString: String
    let punchImageString: String
    let backgroundImageString: String
}

extension Shop {
    var shopKey: String {
        return "user-points-\(name)"
    }
}

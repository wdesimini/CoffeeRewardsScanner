//
//  Shop.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/16/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit


struct Shop {
    let name: String
    let logoImageString: String
    let cupImageString: String
    let punchImageString: String
    let backgroundImageString: String
    let cardColor: UIColor
}

extension Shop: Hashable {
    static func == (lhs: Shop, rhs: Shop) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Shop {
    var shopKey: String {
        return "user-points-\(name)"
    }
}

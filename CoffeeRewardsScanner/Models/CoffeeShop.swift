//
//  CoffeeShop.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/14/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


struct Shop {
    let name: String
    let image: String?
    
    var shopKey: String {
        return "user-points-\(name)"
    }
}

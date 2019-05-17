//
//  Card.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/14/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


struct Card {
    let shop: SanDiegoCoffeeShop
    
    var points: Int {
        get {
            return UserDefaults.standard.value(forKey: shopKey) as? Int ?? 0
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: shopKey)
        }
    }
    
    mutating func addPoints(amount: Int) {
        points += amount
    }
    
    mutating func usePoints() {
        guard points >= 10 else { return }
        
        points -= 10
    }
}

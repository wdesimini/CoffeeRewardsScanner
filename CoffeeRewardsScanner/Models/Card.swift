//
//  Card.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/14/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


struct Card {
    let shop: Shop
    
    var points: Int {
        get {
            return UserDefaults.standard.value(forKey: shop.shopKey) as? Int ?? 0
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: shop.shopKey)
        }
    }
}

extension Card: Hashable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.shop.name == rhs.shop.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(shop.name)
    }
}

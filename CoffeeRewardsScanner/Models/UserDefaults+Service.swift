//
//  UserDefaults+Service.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/24/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit


extension UserDefaults {
    
    var currentCard: Card {
        
        guard
            let shopName = value(forKey: UserDefaultKey.currentCardName) as? String,
            let currentShop = (ShopsData.shopList.filter { $0.name == shopName }).first else {
                let defaultShop = ShopsData.shopList[0]
                updateCurrentCard(to: defaultShop) // update to default
                return Card(shop: defaultShop) // return default if there is none
        }
        
        return Card(shop: currentShop)
    }
    
    func updateCurrentCard(to shop: Shop) {
        set(shop.name, forKey: UserDefaultKey.currentCardName)
    }
}

private struct UserDefaultKey {
    static let currentCardName = "currentCard-shopName"
}

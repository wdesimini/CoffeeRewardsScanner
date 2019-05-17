//
//  User+Service.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/16/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


//extension User {
//    
//    func addNewCard(from shop: Shop) {
//        var card = Card(shop: shop)
//        card.points = 0
//        cards.append(card)
//    }
//}
//
//private let currentShopKey = UserDefaultsKeyArray.currentCardShop
//
//extension UserDefaults {
//    
//    var currentCardShop: SanDiegoCoffeeShop? {
//        if let shopString = value(forKey: currentShopKey) as? String {
//            return SanDiegoCoffeeShop(rawValue: shopString)
//        } else {
//            return nil
//        }
//    }
//    
//    func updateCurrentCard(to shop: SanDiegoCoffeeShop) {
//        set(shop.rawValue, forKey: currentShopKey)
//    }
//}
//
//private struct UserDefaultsKeyArray {
//    static let currentCardShop = "currentCardShop"
//}

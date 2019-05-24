//
//  Card+Service.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/17/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit


extension Card {
    
    mutating func addPoints(amount: Int) {
        points += amount
    }
    
    mutating func usePoints() {
        guard points >= 10 else { return }
        points -= 10
    }
    
    var logoImage: UIImage {
        return UIImage(named: shop.logoImageString)!
    }
    
    var color: UIColor {
        return shop.cardColor
    }
    
    var cupImage: UIImage {
        return UIImage(named: shop.cupImageString)!
    }
    
    var punchImage: UIImage {
        return UIImage(named: shop.punchImageString)!
    }
    
    var backgroundImage: UIImage {
        return UIImage(named: shop.backgroundImageString)!
    }
}

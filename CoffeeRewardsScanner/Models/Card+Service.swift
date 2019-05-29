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
        switch shop.cardTheme {
        case .light:
            return .white
        case .dark:
            return .darkGray
        }
    }
    
    var cupImage: UIImage {
        switch shop.cardTheme {
        case .light:
            return UIImage(named: "BlackCup")!
        case .dark:
            return UIImage(named: "WhiteCup")!
        }
    }
    
    var punchImage: UIImage {
        switch shop.cardTheme {
        case .light:
            return UIImage(named: "BlackAddPunch")!
        case .dark:
            return UIImage(named: "WhiteAddPunch")!
        }
    }
    
    var backgroundImage: UIImage {
        switch shop.background {
        case .wooden:
            return UIImage(named: "WoodBackground")!
        case .grunge:
            return UIImage(named: "GrungeBackground")!
        }
    }
}

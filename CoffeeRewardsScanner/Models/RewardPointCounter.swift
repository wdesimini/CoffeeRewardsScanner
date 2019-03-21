//
//  RewardPointCounter.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 3/5/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation

class RewardPointCounter {
    
    var pointCount: Int = 0
    
    func increaseCount(by amount: Int) {
        pointCount += amount
        
        UserDefaults.standard.set(pointCount, forKey: "user-count")
    }
    
    func usePoints() {
        guard pointCount >= 10 else {
            print("user doesn't have enough points to use them")
            print("pointCount: \(pointCount)")
            
            return
        }
        
        pointCount -= 10
        
        UserDefaults.standard.set(pointCount, forKey: "user-count")
    }
    
}

#warning("DELETE BELOW THIS LINE, FOR MARKETING TO MULTIPLE SHOPS")

import UIKit

struct ShopView {
    
    var shop: Shop
    
    init(shop: Shop) {
        self.shop = shop
    }
    
    var logoImage: UIImage {
        
        switch shop {
        case .betterBuzz:
            return UIImage(named: "BetterBuzzLogo")!
        case .birdRock:
            return UIImage(named: "BirdRockLogo")!
        case .coava:
            return UIImage(named: "CoavaLogo")!
        case .communal:
            return UIImage(named: "CommunalCoffeeLogo")!
        case .darkHorse:
            return UIImage(named: "DarkHorseLogo")!
        case .heartWork:
            return UIImage(named: "HeartworkLogo")!
        case .holsem:
            return UIImage(named: "HolsemLogo")!
        case .james:
            return UIImage(named: "JamesCoffeeCoLogo")!
        case .lofty:
            return UIImage(named: "LoftyLogo")!
        case .moniker:
            return UIImage(named: "MonikerGeneralLogo")!
        case .subterranean:
            return UIImage(named: "SubterraneanLogo")!
        case .westBean:
            return UIImage(named: "WestBeanLogo")!
        }
    }
    
    var cardColor: UIColor {
        switch shop {
        case .betterBuzz, .birdRock, .communal, .holsem, .james, .lofty, .moniker, .westBean:
            return .white
        case .coava, .darkHorse, .heartWork:
            return .darkGray
        case .subterranean:
            return UIColor(red: 43 / 255, green: 43 / 255, blue: 43 / 255, alpha: 1.0)
        }
    }
    
    var cupImage: UIImage {
        switch shop {
        case .betterBuzz, .birdRock, .communal, .holsem, .james, .lofty, .moniker, .westBean:
            return UIImage(named: "GreyCup")!
        case .coava, .darkHorse, .heartWork, .subterranean:
            return UIImage(named: "WhiteCup")!
        }
    }
    
    var punchImage: UIImage {
        switch shop {
        case .betterBuzz, .birdRock, .communal, .holsem, .james, .lofty, .moniker, .westBean:
            return UIImage(named: "AddBlackPunch")!
        case .coava, .darkHorse, .heartWork, .subterranean:
            return UIImage(named: "AddPunch")!
        }
    }
    
    var backgroundImage: UIImage {
        switch shop {
        case .birdRock, .darkHorse, .james, .subterranean:
            return UIImage(named: "WoodBackground")!
        case .betterBuzz, .coava, .communal, .heartWork, .holsem, .lofty, .moniker, .westBean:
            return UIImage(named: "GrungeBackground")!
        }
    }
    
}

enum Shop {
    
    case betterBuzz, birdRock, coava, communal, darkHorse, heartWork, holsem, james, lofty, moniker, subterranean, westBean
    
}

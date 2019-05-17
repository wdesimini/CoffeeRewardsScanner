//
//  Card+Service.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/17/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit


extension Card {
    
    var shopKey: String {
        return "user-points-\(name)"
    }
    
    var name: String {
        switch shop {
        case .betterBuzz: return "Better Buzz"
        case .birdRock: return "BirdRock Coffee"
        case .coava: return "Coava"
        case .communal: return "Communal Coffee"
        case .darkHorse: return "Dark Horse Coffee Roasters"
        case .heartWork: return "Heartwork Coffee"
        case .holsem: return "Holsem Coffee"
        case .james: return "James Coffee"
        case .lofty: return "Lofty Coffee"
        case .moniker: return "Moniker"
        case .subterranean: return "Subterranean Coffee Roasters"
        case .westBean: return "The WestBean Coffee Roasters"
        }
    }
    var logoImage: UIImage {
        switch shop {
        case .betterBuzz: return UIImage(named: "BetterBuzzLogo")!
        case .birdRock: return UIImage(named: "BirdRockLogo")!
        case .coava: return UIImage(named: "CoavaLogo")!
        case .communal: return UIImage(named: "CommunalCoffeeLogo")!
        case .darkHorse: return UIImage(named: "DarkHorseLogo")!
        case .heartWork: return UIImage(named: "HeartworkLogo")!
        case .holsem: return UIImage(named: "HolsemLogo")!
        case .james: return UIImage(named: "JamesCoffeeCoLogo")!
        case .lofty: return UIImage(named: "LoftyLogo")!
        case .moniker: return UIImage(named: "MonikerGeneralLogo")!
        case .subterranean: return UIImage(named: "SubterraneanLogo")!
        case .westBean: return UIImage(named: "WestBeanLogo")!
        }
    }
    
    var color: UIColor {
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

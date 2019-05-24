//
//  Shop+Service.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/22/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit


struct ShopsData {
    
    static let shopList = [
        Shop(
            name: "Coava",
            logoImageString: "Coava_logo",
            cupImageString: "WhiteCup",
            punchImageString: "AddPunch",
            backgroundImageString: "GrungeBackground",
            cardColor: .darkGray),
        Shop(
            name: "Better Buzz",
            logoImageString: "BetterBuzz_logo",
            cupImageString: "BlackCup",
            punchImageString: "AddBlackPunch",
            backgroundImageString: "WoodBackground",
            cardColor: .white)
    ]
    
}

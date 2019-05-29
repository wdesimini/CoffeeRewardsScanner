//
//  Shop+Data.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/26/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import CoreLocation


struct ShopsData {
    
    static let shopList = [
        Shop(
            name: "Coava",
            logoImageString: "Coava_logo",
            background: .grunge,
            cardTheme: .dark,
            coordinates: CLLocationCoordinate2D(
                latitude: 32.715930,
                longitude: -117.167250)),
        Shop(
            name: "Better Buzz",
            logoImageString: "BetterBuzz_logo",
            background: .wooden,
            cardTheme: .light,
            coordinates: CLLocationCoordinate2D(
                latitude: 32.748215,
                longitude: -117.156998)),
        Shop(
            name: "Lofty",
            logoImageString: "Lofty_logo",
            background: .grunge,
            cardTheme: .light,
            coordinates: CLLocationCoordinate2D(
                latitude: 32.722145,
                longitude: -117.167226))
    ]
    
}

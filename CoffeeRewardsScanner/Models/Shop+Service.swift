//
//  Shop+Service.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/22/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


extension Shop {
    
    enum CardTheme {
        case light, dark
    }
    
    enum CardBackground {
        case wooden, grunge
    }
    
    var shopKey: String {
        return "user-points-\(name)"
    }
    
    var regionId: String {
        return "region-\(name)"
    }
    
    var circularRegion: CLCircularRegion {
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100.0,
            identifier: regionId)
        
        region.notifyOnEntry = true
        region.notifyOnExit = false
        return region
    }
}

extension Shop: Hashable {
    static func == (lhs: Shop, rhs: Shop) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

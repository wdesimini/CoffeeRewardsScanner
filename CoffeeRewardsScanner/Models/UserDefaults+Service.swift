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
    
    var updateByRegion: Bool {
        return value(forKey: UserDefaultKey.updateByRegion) as? Bool ?? true // default is true
    }
    
    func toggleUpdateByRegionSetting() {
        let currentSetting = updateByRegion
        set(!currentSetting, forKey: UserDefaultKey.updateByRegion)
    }
    
    open override func didChangeValue(forKey key: String) {
        switch key {
        case UserDefaultKey.updateByRegion:
            let locationManager = LocationManager.shared
            
            if UserDefaults.standard.updateByRegion {
                locationManager.startMonitoringByRegion()
            } else {
                locationManager.stopMonitoringByRegion()
            }
        default: break
        }
    }
}

private struct UserDefaultKey {
    static let currentCardName = "currentCard-shopName"
    static let updateByRegion = "updateByRegion"
    static let locationTracking = "locationTracking"
}

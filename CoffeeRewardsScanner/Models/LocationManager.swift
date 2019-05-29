//
//  LocationManager.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/25/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class LocationManager: NSObject {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    static let shared: LocationManager = {
        let manager = LocationManager()
        return manager
    }()
    
    func startMonitoringByRegion() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            ShopsData.shopList.forEach {
                locationManager.startMonitoring(for: $0.circularRegion)
            }
        }
    }
    
    func stopMonitoringByRegion() {
        ShopsData.shopList.forEach {
            locationManager.stopMonitoring(for: $0.circularRegion)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let circularRegion = region as? CLCircularRegion else { return }
            
        // update current card when user gets close to coffee shop
        let shop = (ShopsData.shopList.filter {
            $0.circularRegion == circularRegion
        }).first!
        
        if UserDefaults.standard.updateByRegion {
            NotificationCenter.default.post(
                name: .cardUpdateByRegion,
                object: shop)
        }
    }
}

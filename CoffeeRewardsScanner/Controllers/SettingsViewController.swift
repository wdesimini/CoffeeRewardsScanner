//
//  SettingsViewController.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/25/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import CoreLocation


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var firstBackgroundView: UIView!
    @IBOutlet weak var updateCardSwitch: UISwitch!
    
    let locationManager = LocationManager.shared
    
    override func loadView() {
        super.loadView()
        
        // round corners of backgrounds and add shadow
        firstBackgroundView.layer.cornerRadius = Size.backgroundCornerRadius
        
        // load initial switch values
        updateCardSwitch.isOn = UserDefaults.standard.updateByRegion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // set updateByRegion: Bool
    @IBAction func updateCardToggle(_ sender: Any) {
        UserDefaults.standard.toggleUpdateByRegionSetting()
    }
    
    @IBAction func goToSettingsTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    // show drinks earned for each coffee shop
}

extension SettingsViewController {
    private struct Size {
        static let backgroundCornerRadius: CGFloat = 16
    }
}

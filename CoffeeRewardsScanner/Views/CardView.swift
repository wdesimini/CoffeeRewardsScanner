//
//  CardView.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/17/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit


extension UIView {
    
    func configureCardView() {
        let cornerRadius: CGFloat = 10
        layer.cornerRadius = cornerRadius
        
        // add shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.75)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.5
    }
    
}

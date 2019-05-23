//
//  CameraFrame.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 3/6/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class CameraFrame: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 20.0)
        context.addPath(path.cgPath)
        context.setStrokeColor(UIColor.orange.cgColor)
        context.setLineWidth(15.0)
        context.drawPath(using: .stroke)
    }
    
}

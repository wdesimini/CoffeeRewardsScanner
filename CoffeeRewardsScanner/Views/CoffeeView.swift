//
//  CoffeeView.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 3/6/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

private let coffeeColor = UIColor(red: 0.435, green: 0.306, blue: 0.216, alpha: 1)

class CoffeeView: UIView {
    
    var waveCount: Int
    
    init(waveCount: Int) {
        self.waveCount = waveCount
        
        let bounds = UIScreen.main.bounds
        let newFrame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height + (bounds.width / CGFloat(waveCount)))
        super.init(frame: newFrame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // multiple between edges of view
        
        let diameter = rect.width / CGFloat(waveCount)
        let radius = diameter / 2.0
        
        let startY = radius
        
        // make x amount of strides across screen
        let wavePath = UIBezierPath()
        
        for index in 1...waveCount {
            
            let x = radius + diameter * CGFloat(index - 1)
            
            let center = CGPoint(x: x, y: CGFloat(startY))
            
            let isEven = index % 2 == 0
            
            var start = CGFloat()
            var end = CGFloat()
            
            if isEven {
                start = CGFloat(Double.pi)
                end = CGFloat(0)
            } else {
                start = CGFloat(0)
                end = CGFloat(Double.pi)
            }
            
            wavePath.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: false)
        }
        
        // extend bottom of UIView
        let bottomPoint = rect.height + diameter
        
        wavePath.addLine(to: CGPoint(x: rect.width, y: bottomPoint))
        wavePath.addLine(to: CGPoint(x: 0, y: bottomPoint))
        wavePath.addLine(to: CGPoint(x: 0, y: startY))
        
        context.addPath(wavePath.cgPath)
        
        context.setFillColor(coffeeColor.cgColor)
        
        context.setStrokeColor(coffeeColor.cgColor)
        context.setLineWidth(10.0)
        
        context.drawPath(using: .fill)
    }
}


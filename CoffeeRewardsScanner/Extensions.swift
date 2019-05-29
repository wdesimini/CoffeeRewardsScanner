//
//  Extensions.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 3/6/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

// extension to rotate UIImage

extension UIImage {
    
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            
            draw(in: CGRect(x: -origin.x, y: -origin.y,
                            width: size.width, height: size.height))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
    
}

// add pulse effect to UIImageView

extension UIImageView {
    
    func addPulseAnimation() {
        
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.1
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1000
        animationGroup.animations = [pulse1]
        
        layer.add(animationGroup, forKey: "pulse")
    }
}

// glow effect around UIView

extension UIView{
    
    enum GlowEffect:Float{
        case small = 0.4, normal = 5, big = 15
    }
    
    func doGlowAnimation(withColor color:UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        
        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.duration = 0.6
        glowAnimation.fromValue = 0
        glowAnimation.toValue = effect.rawValue
        glowAnimation.fillMode = CAMediaTimingFillMode.removed
        glowAnimation.autoreverses = true
        glowAnimation.repeatCount = 1
        
        let animationGroup = CAAnimationGroup()
        
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1000
        animationGroup.animations = [glowAnimation]
        layer.add(animationGroup, forKey: "shadowGlowingAnimation")
    }
    
}

// apply gradient to UIView

extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, start: CGPoint, end: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// show alert in controller

extension UIViewController {
    
    func showAlert(_ title: String?,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// Notification Names

extension NSNotification.Name {
    static let cardUpdateByRegion = NSNotification.Name("cardUpdateByRegion")
    static let updateByRegionToggle = NSNotification.Name("updateByRegionToggle")
}

//
//  ContainerViewController.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/23/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var cardNavigationController: UINavigationController!
    var cardViewController: CardViewController!
    var shopsViewController: ShopsViewController!
    
    var shopControllerShowing = false {
        didSet {
            if shopControllerShowing {
                cardNavigationController.view.layer.shadowOpacity = 0.8
            } else {
                cardNavigationController.view.layer.shadowOpacity = 0.0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        cardViewController = storyboard.instantiateViewController(withIdentifier: "cardViewController") as? CardViewController
        cardViewController.delegate = self
        
        cardNavigationController = UINavigationController(rootViewController: cardViewController)
        view.addSubview(cardNavigationController.view)
        addChild(cardNavigationController)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        cardViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func addShopsViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        shopsViewController = storyboard.instantiateViewController(withIdentifier: "shopsViewController") as? ShopsViewController
        view.insertSubview(shopsViewController.view, at: 0)
        addChild(shopsViewController)
        shopsViewController.delegate = cardViewController
        shopsViewController.didMove(toParent: self)
    }
    
    func animateShopsController(shouldExpand: Bool) {
        if shouldExpand {
            shopControllerShowing = true
            animateCenterPanelXPosition(
                targetPosition: cardNavigationController.view.frame.width - Size.cardViewOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.shopControllerShowing = false
                self.shopsViewController?.view.removeFromSuperview()
                self.shopsViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                self.cardNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
}

extension ContainerViewController {
    private struct Size {
        static let cardViewOffset: CGFloat = 90
    }
}

extension ContainerViewController: CardViewControllerDelegate {
    func toggleShopsMenu() {
        if !shopControllerShowing {
            addShopsViewController()
        }
        
        animateShopsController(shouldExpand: !shopControllerShowing)
    }
}

// MARK: Gesture recognizer

extension ContainerViewController: UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
        case .began:
            if !shopControllerShowing && gestureIsDraggingFromLeftToRight {
                addShopsViewController()
            }
            
        case .changed:
            if let rview = recognizer.view {
                rview.center.x = rview.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint.zero, in: view)
            }
            
        case .ended:
            guard shopsViewController != nil else { return }
            
            if let rview = recognizer.view {
                animateShopsController(shouldExpand: rview.center.x > view.bounds.size.width)
            }
        default: break
        }
    }
}

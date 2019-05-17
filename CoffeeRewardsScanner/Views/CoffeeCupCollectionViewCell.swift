//
//  CoffeeCupCollectionViewCell.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 3/6/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class CoffeeCupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cupImageView: UIImageView!
    var card: Card!
    
    func setImage(_ index: Int) {
        
        var cupImage: UIImage
        
        // check if cup is within punch range
        let punched = index + 1 <= card.points
        
        if punched {
            cupImage = UIImage(named: "RedCup")!
        } else {
            cupImage = card.cupImage
        }
        
        cupImageView.image = cupImage.rotate(radians: -.pi/2)
    }
}


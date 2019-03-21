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
    var unpunchedCupImage: UIImage!
    
    func setImage(_ index: Int, pointCount: Int) {
        
        var cupImage: UIImage
        
        // check if cup is within punch range
        let punched = index + 1 <= pointCount
        
        if punched {
            cupImage = UIImage(named: "RedCup")!
        } else {
            cupImage = unpunchedCupImage
        }
        
        cupImageView.image = cupImage.rotate(radians: -.pi/2)
    }
}


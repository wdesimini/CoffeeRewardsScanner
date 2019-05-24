//
//  ViewController.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 3/5/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit


class CardViewController: UIViewController{
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var punchImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var coffeeImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var shopsButton: UIBarButtonItem!
    
    var card: Card? {
        didSet {
            guard card != nil else { return }
            UserDefaults.standard.updateCurrentCard(to: card!.shop)
            
            DispatchQueue.main.async {
                self.setCardViews()
                self.refreshCardView()
                self.tableView.reloadData()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        super.loadView()
        card = UserDefaults.standard.currentCard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewLeadingConstraint.constant = tableViewWidth.constant
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "avSessionSegue",
            let destNavigationController = segue.destination as? UINavigationController {
            let destVC = destNavigationController.visibleViewController as! AVSessionViewController
            destVC.delegate = self
        }
    }
    
    @IBAction func getCode(_ sender: Any) {
        performSegue(withIdentifier: "avSessionSegue", sender: nil)
    }
    
    @IBAction func usePointsTapped(_ sender: Any) {
        card!.usePoints()
        showAlert("Enjoy Your Drink!", "Show this to the barista to redeem 1 free drink")
        pourCoffee()
        
        // remove pulse and glow animations
        collectionView.layer.removeAllAnimations()
        coffeeImage.layer.removeAllAnimations()
    }
    
    var tableViewShowing: Bool = false
    
    @IBAction func shopsTapped(_ sender: Any) {
        animateShopsTableView()
    }
    
    private func setCardViews() {
        cardView.configureCardView()
        
        // shop specific modifications
        backgroundImageView.image = card!.backgroundImage
        cardView.backgroundColor = card!.color
        logoImageView.image = card!.logoImage
        punchImageView.image = card!.punchImage
    }
    
    private func animateShopsTableView() {
        // animate tableView to show
        UIView.animate(
            withDuration: 0.4,
            animations: {
                self.setShopsView()
        })
    }
    
    private func setShopsView() {
        
        if tableViewShowing {
            shopsButton.title = "Shops"
            tableViewLeadingConstraint.constant = tableViewWidth.constant
            tableView.layer.shadowOpacity = 0.5
            tableView.layer.shadowRadius = 6
        } else {
            shopsButton.title = "Cancel"
            tableViewLeadingConstraint.constant = 0
            tableView.layer.shadowOpacity = 0
            tableView.layer.shadowRadius = 0
        }
        
        view.layoutSubviews()
        tableViewShowing = !tableViewShowing
    }
    
    private func refreshCardView() {
        // reload collectionView to see how many punched
        collectionView.reloadData()
        addAnimationForEnoughPunches()
    }
    
    private func addAnimationForEnoughPunches() {
        if card!.points >= 10 {
            // animate coffeeImage
            coffeeImage.addPulseAnimation()
            
            // make coffeeImage and collectionView cups glow
            collectionView.doGlowAnimation(withColor: .yellow)
            coffeeImage.doGlowAnimation(withColor: .yellow)
        }
    }
    
    private func pourCoffee() {
        let coffeeView = CoffeeView(waveCount: CardSizes.coffeeWaveCount)

        // start at bottom
        coffeeView.frame.origin.y = view.frame.size.height
        view.addSubview(coffeeView)

        // animate up screen
        let radius = view.frame.size.width / CGFloat(CardSizes.coffeeWaveCount)

        UIView.animate(withDuration: 5, animations: { coffeeView.frame.origin.y = -radius }) { _ in
            // fade out
            UIView.animate(withDuration: 1, animations: {
                // maybe add steam animation here?
                coffeeView.alpha = 0
            })
        }
    }
}

extension CardViewController {
    private struct CardSizes {
        static let coffeeWaveCount: Int = 30
    }
}

// Coffee cup collectionView

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCupCollectionCell", for: indexPath) as! CoffeeCupCollectionViewCell
        cell.card = card!
        cell.setImage(indexPath.item)
        return cell
    }
}

// Shops tableView

extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShopsData.shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        let shop = ShopsData.shopList[indexPath.row]
        cell.textLabel?.text = shop.name
        
        // put checkmark next to selected shop cell
        if shop == card?.shop {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        card = Card(shop: ShopsData.shopList[indexPath.row])
        animateShopsTableView()
    }
}

extension CardViewController: AVSessionViewControllerDelegate {
    
    func captureOutput(value: Int) {
        card!.addPoints(amount: value)
    }
    
}

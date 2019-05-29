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
    
    private lazy var blurEffectView = createBlurLayer()
    
    private func createBlurLayer() -> UIVisualEffectView {
        let blurEffectView = UIVisualEffectView(
            effect: UIBlurEffect(style: .dark)
        )
        
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, belowSubview: tableView)
        return blurEffectView
    }
    
    private lazy var coffeeView = getCoffeeView()
    
    private func getCoffeeView() -> CoffeeView {
        let coffeeView = CoffeeView()
        coffeeView.frame.origin.y = view.frame.size.height // start at bottom
        view.addSubview(coffeeView)
        return coffeeView
    }
    
    var card: Card! {
        didSet {
            UserDefaults.standard.updateCurrentCard(to: card.shop)
            
            DispatchQueue.main.async {
                self.setCardViews()
                self.refreshCardView()
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        card = UserDefaults.standard.currentCard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set tableView appearance
        tableViewLeadingConstraint.constant = tableViewWidth.constant
        
        // detect whether user has card by region observer on or off
        updateCardByRegionObserver()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateByRegionToggled),
            name: .updateByRegionToggle,
            object: nil)
        
        addCardUpdateObserver()
    }
    
    @objc func updateByRegionToggled() {
        updateCardByRegionObserver()
    }
    
    private func updateCardByRegionObserver() {
        if UserDefaults.standard.updateByRegion {
            addCardUpdateObserver()
        } else {
            removeCardUpdateObserver()
        }
    }
    
    private func addCardUpdateObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cardUpdatedByRegion),
            name: .cardUpdateByRegion,
            object: nil)
    }
    
    private func removeCardUpdateObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: .cardUpdateByRegion,
            object: nil)
    }
    
    @objc func cardUpdatedByRegion(_ notification: Notification) {
        // if update by region not selected, don't do anything
        guard UserDefaults.standard.updateByRegion else { return }
        
        // show alert asking if user would like to use card in current region
        let nearbyShop = notification.object as! Shop
        
        let alert = UIAlertController(
            title: "Shop Detected",
            message: "Looks like you're near \(nearbyShop.name), would you like to switch to their card?",
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: nil,
                style: .default) { _ in
                    // switch to card
                    self.card = Card(shop: nearbyShop)
            }
        )
        
        alert.addAction(UIAlertAction(title: nil, style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "avSessionSegue",
            let destNavigationController = segue.destination as? UINavigationController {
            let destVC = destNavigationController.visibleViewController as! AVSessionViewController
            destVC.delegate = self
        }
    }
    
    @IBAction func punchTapped(_ sender: Any) {
        performSegue(withIdentifier: "avSessionSegue", sender: nil)
    }
    
    @IBAction func usePointsTapped(_ sender: Any) {
        card.usePoints()
        showAlert("Enjoy Your Drink!", "Show this to the barista to redeem 1 free drink")
        coffeeView.pourCoffee()
        
        // remove pulse and glow animations
        collectionView.layer.removeAllAnimations()
        coffeeImage.layer.removeAllAnimations()
    }
    
    var tableViewShowing: Bool = false
    
    @IBAction func shopsTapped(_ sender: Any) {
        animateShopsTableView()
    }
    
    private func setCardViews() {
        configureCardView()
        
        // shop specific modifications
        backgroundImageView.image = card.backgroundImage
        cardView.backgroundColor = card.color
        logoImageView.image = card.logoImage
        punchImageView.image = card.punchImage
    }
    
    private func configureCardView() {
        cardView.layer.cornerRadius = Size.cardCornerRadius
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView.layer.shadowRadius = Size.cardShadowRadius
        cardView.layer.shadowOpacity = 0.5
    }
    
    private func animateShopsTableView() {
        // animate tableView to show
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.transitionCrossDissolve],
            animations: {
                self.setShopsView()
        })
    }
    
    private func setShopsView() {
        if tableViewShowing {
            shopsButton.title = "Shops"
            tableViewLeadingConstraint.constant = tableViewWidth.constant
            blurEffectView.alpha = 0
        } else {
            shopsButton.title = "Cancel"
            tableViewLeadingConstraint.constant = 0
            blurEffectView.alpha = 1
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
        if card.points >= 10 {
            // animate coffeeImage
            coffeeImage.addPulseAnimation()
            
            // make coffeeImage and collectionView cups glow
            collectionView.doGlowAnimation(withColor: .yellow)
            coffeeImage.doGlowAnimation(withColor: .yellow)
        }
    }
}

extension CardViewController {
    private struct Size {
        static let cardCornerRadius: CGFloat = 12
        static let cardShadowRadius: CGFloat = 10
    }
}

// Coffee cup collectionView

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCupCollectionCell", for: indexPath) as! CoffeeCupCollectionViewCell
        cell.card = card
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
        cell.textLabel?.textColor = cell.tintColor
        
        // put checkmark next to selected shop cell
        if shop == card.shop {
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
        card.addPoints(amount: value)
    }
    
}

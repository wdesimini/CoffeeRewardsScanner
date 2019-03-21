//
//  ViewController.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 3/5/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import AVFoundation

class CardViewController: UIViewController{
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var punchImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var coffeeImage: UIImageView!
    
    #warning("FOR MULTIPLE SHOP MARKETING DELETE")
    let shop = ShopView(shop: .coava)
    
    var rewardPointCounter = RewardPointCounter()
    var video = AVCaptureVideoPreviewLayer()
    
    //Creating session
    let session = AVCaptureSession()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setAVSession()
        setRewardsCounter()
        addAnimationForEnoughPunches()
    }
    
    func setViews() {
        // setCardViews
        setCardViews()
        
        // set background view
        setBackground()
    }
    
    func setCardViews() {
        
        let cornerRadius: CGFloat = 10
        cardView.layer.cornerRadius = cornerRadius
        
        // add shadow
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView.layer.shadowRadius = 10.0
        cardView.layer.shadowOpacity = 0.5
        
        #warning("FOR MULTIPLE SHOP MARKETING DELETE")
        // shop specific modifications
        logoImageView.image = shop.logoImage
        cardView.backgroundColor = shop.cardColor
        punchImageView.image = shop.punchImage
    }
    
    func setBackground() {
        
        backgroundImageView.image = shop.backgroundImage
    }
    
    func setAVSession() {
        //Define capture devcie
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            print ("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = UIScreen.main.bounds
        view.layer.addSublayer(video)
    }
    
    
    func setRewardsCounter() {
        let userCount = UserDefaults.standard.value(forKey: "user-count") as? Int
        
        rewardPointCounter.pointCount = userCount ?? 0
    }
    
    // orange square in middle of frame
    let cameraFrame = CameraFrame(frame: CGRect.zero)
    
    @IBAction func getCode(_ sender: Any) {
        session.startRunning()
        setSessionView()
    }
    
    func setSessionView() {
        video.isHidden = false
        
        cameraFrame.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        cameraFrame.center = view.center
        
        view.addSubview(cameraFrame)
    }
    
    @IBAction func usePointsTapped(_ sender: Any) {
        guard rewardPointCounter.pointCount >= 10 else {
            showAlert(nil, "You don't have enough points for a free cup yet")
            
            return
        }
        
        // call usePoints method on rewards counter
        rewardPointCounter.usePoints()
        
        // refresh view based on rewardPointCounter
        refreshView()
        
        // show alert saying enjoy your free drink
        showAlert("Enjoy Your Drink!", "Show this to the barista to redeem 1 free drink")
        
//        pourCoffee()
        
        // remove pulse and glow animations
        collectionView.layer.removeAllAnimations()
        coffeeImage.layer.removeAllAnimations()
    }
    
    func refreshView() {
        // reload collectionView to see how many punched
        collectionView.reloadData()
        
        addAnimationForEnoughPunches()
    }
    
    func addAnimationForEnoughPunches() {
        // check if quantity at least 10, if so show use button
        guard rewardPointCounter.pointCount >= 10 else {
            return
        }
        
        // animate coffeeImage
        coffeeImage.addPulseAnimation()
        
        // make coffeeImage and collectionView cups glow
        collectionView.doGlowAnimation(withColor: .yellow)
        coffeeImage.doGlowAnimation(withColor: .yellow)
    }
    
    func pourCoffee() {
        
        let waveCount = 30
        let coffeeView = CoffeeView(waveCount: waveCount)
        
        // start at bottom
        
        coffeeView.frame.origin.y = view.frame.size.height
        
        // add sub views to coffee view to make it look better

        // steam?
        // noise of coffee pouring?
        
        view.addSubview(coffeeView)
        
        let radius = UIScreen.main.bounds.width / CGFloat(waveCount)
        // animate up screen
        UIView.animate(withDuration: 5, animations: { coffeeView.frame.origin.y = -radius }) { _ in
            // fade out
            UIView.animate(withDuration: 1, animations: {
                // maybe add steam animation here?
                coffeeView.alpha = 0
            })
        }
        
    }
}

// Scanning QR Code

extension CardViewController: AVCaptureMetadataOutputObjectsDelegate  {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard metadataObjects.count != 0,
            let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
        
        if object.type == AVMetadataObject.ObjectType.qr {
            guard let stringValue = object.stringValue, let value = Int(stringValue) else { return }
            
            rewardPointCounter.increaseCount(by: value)
            
            // stop AV session
            session.stopRunning()
            
            // hide AV views
            video.isHidden = true
            cameraFrame.removeFromSuperview()
            
            refreshView()
        }
    }
}

// Coffee cup collectionView

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCupCollectionCell", for: indexPath) as! CoffeeCupCollectionViewCell
        
        #warning("FOR MULTIPLE SHOP MARKETING DELETE")
        // set cell
        cell.unpunchedCupImage = shop.cupImage
        cell.setImage(indexPath.item, pointCount: rewardPointCounter.pointCount)
        
        return cell
    }
}

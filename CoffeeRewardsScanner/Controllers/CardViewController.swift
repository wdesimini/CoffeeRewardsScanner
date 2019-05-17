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
    
    // orange square in middle of frame
    private lazy var cameraFrame = createCameraFrame()
    
    private func createCameraFrame() -> UIView {
        let cameraFrame = CameraFrame(frame: .zero)
        cameraFrame.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        cameraFrame.center = view.center
        view.addSubview(cameraFrame)
        return cameraFrame
    }
    
    var user: User?
    
    var card: Card? {
        didSet {
            refreshCardView()
        }
    }
    
    //Creating session
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        super.loadView()
        card = Card(shop: .coava)
        setCardViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAVSession()
        addAnimationForEnoughPunches()
    }
    
    private func setCardViews() {
        cardView.configureCardView()
        
        // shop specific modifications
        backgroundImageView.image = card!.backgroundImage
        cardView.backgroundColor = card!.color
        logoImageView.image = card!.logoImage
        punchImageView.image = card!.punchImage
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
        video.addSublayer(cameraFrame.layer)
        video.isHidden = true
    }
    
    @IBAction func getCode(_ sender: Any) {
        session.startRunning()
        setSessionView()
    }
    
    func setSessionView() {
        video.isHidden = false
    }
    
    @IBAction func usePointsTapped(_ sender: Any) {
        card!.usePoints()
        showAlert("Enjoy Your Drink!", "Show this to the barista to redeem 1 free drink")
        
//        pourCoffee()
        
        // remove pulse and glow animations
        collectionView.layer.removeAllAnimations()
        coffeeImage.layer.removeAllAnimations()
    }
    
    private func refreshCardView() {
        // reload collectionView to see how many punched
        collectionView.reloadData()
        addAnimationForEnoughPunches()
    }
    
    func addAnimationForEnoughPunches() {
        if card!.points >= 10 {
            // animate coffeeImage
            coffeeImage.addPulseAnimation()
            
            // make coffeeImage and collectionView cups glow
            collectionView.doGlowAnimation(withColor: .yellow)
            coffeeImage.doGlowAnimation(withColor: .yellow)
        }
    }
    
    func pourCoffee() {
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

// Scanning QR Code

extension CardViewController: AVCaptureMetadataOutputObjectsDelegate  {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard
            metadataObjects.count != 0,
            let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
        
        if object.type == AVMetadataObject.ObjectType.qr {
            guard let stringValue = object.stringValue, let value = Int(stringValue) else { return }
            handlePointAddition(amount: value)
        }
    }
    
    private func handlePointAddition(amount: Int) {
        card!.addPoints(amount: amount)
        
        // stop AV session and hide views
        session.stopRunning()
        video.isHidden = true
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

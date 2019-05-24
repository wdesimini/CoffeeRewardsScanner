//
//  AVSessionViewController.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/24/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import AVFoundation


protocol AVSessionViewControllerDelegate: class {
    func captureOutput(value: Int)
}

class AVSessionViewController: UIViewController {
    // orange square in middle of frame
    private lazy var cameraFrame = createCameraFrame()
    
    private func createCameraFrame() -> UIView {
        let cameraFrame = CameraFrame(frame: .zero)
        cameraFrame.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        cameraFrame.center = view.center
        view.addSubview(cameraFrame)
        return cameraFrame
    }
    
    //Creating session
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    weak var delegate: AVSessionViewControllerDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAVSession()
    }
    
    private func setAVSession() {
        //Define capture device
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
        
        session.startRunning()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// Scanning QR Code

extension AVSessionViewController: AVCaptureMetadataOutputObjectsDelegate  {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard
            metadataObjects.count != 0,
            let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
        
        if object.type == AVMetadataObject.ObjectType.qr {
            guard let stringValue = object.stringValue, let value = Int(stringValue) else { return }
            delegate?.captureOutput(value: value)
            session.stopRunning()
            dismiss(animated: true, completion: nil)
        }
    }
}

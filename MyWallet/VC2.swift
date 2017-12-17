//
//  VC2.swift
//  MyWallet
//
//  Created by congphuong on 11/24/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import AVFoundation
import UIKit

class VC2: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var detectCode = false
    
    let imagePicker = UIImagePickerController()
    
    let chooseImg: UIBarButtonItem = {
        let bt = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openImgPicker))
        
        return bt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        self.navigationItem.title = "ScanQR"
        let bt = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openImgPicker))
        self.navigationItem.rightBarButtonItem = bt
        self.imagePicker.delegate = self
        
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
            print("capture")
        } else {
            failed()
            return
        }
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    @objc func openImgPicker(){
        print("Open CLick")
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true) {
            print("Xong")
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
            
        }
        self.detectCode = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        //captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            if !detectCode {
                self.detectCode = true
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                print("capture")
                found(code: stringValue)
            }
        }
        
        //dismiss(animated: true)
        
    }
    
    func found(code: String) {
        print(code)
        API.decode(code: code){
            (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    guard let username = responseJSON["username"] as? String, let exchangemoney = responseJSON["exchangeMoney"] as? Double, let userTo = responseJSON["userTo"] as? Int, let note = responseJSON["note"] as? String else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let stb = UIStoryboard(name: "Main", bundle: nil)
                        let vc2 = stb.instantiateViewController(withIdentifier: "VerifyVC") as? VerifyVC
                        vc2?.stk = String(userTo)
                        vc2?.username = username
                        vc2?.amount = String(exchangemoney) + " vnd"
                        vc2?.note = note
                        vc2?.code = code
                        self.navigationController?.pushViewController(vc2!, animated: true)
                    }
                }
                
                
            }
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("DONE")
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //imageView.contentMode = .ScaleAspectFit
            //imageView.image = pickedImage
            print("DONE IMAGE")
            decodeIMG(img: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func decodeIMG(img: UIImage){
        var code = ""
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        let ciImg = CIImage(image: img)
        let features = detector?.features(in: ciImg!)
        for feature in features as! [CIQRCodeFeature] {
            code += feature.messageString!
        }
        
        print(code)
        found(code: code)
        
    }
    
}

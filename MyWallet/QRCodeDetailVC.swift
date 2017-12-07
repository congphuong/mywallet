//
//  QRCodeDetailVC.swift
//  MyWallet
//
//  Created by congphuong on 11/25/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit

class QRCodeDetailVC: UIViewController {
    var code:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "QR code"
        setupView()
        let btShare = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(btShareClick))
        navigationItem.rightBarButtonItem = btShare
    }
    
    @objc func btShareClick(){
        //let txt = #imageLiteral(resourceName: "Image")
        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    let imgView:UIImageView = {
        let imgv = UIImageView()
        
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.backgroundColor = .red
        return imgv
        
    }()
    
    var img:UIImage?
    
    private func setupView() {
        view.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imgView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width),
            imgView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width)
            ])
        img = generateQRCode(from: code!)
        imgView.image = img
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let txt = NSString(string: "H")
            filter.setValue(txt, forKey: "inputCorrectionLevel")
            
            guard let qrCodeimg = filter.outputImage else {return nil}
            let scaleX = view.frame.size.width / qrCodeimg.extent.width
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                let ciContext = CIContext()
                guard let cgImage = ciContext.createCGImage(output, from: output.extent) else { return nil }
                return UIImage(cgImage: cgImage)
            }
        }
        
        return nil
    }
}

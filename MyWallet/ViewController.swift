//
//  ViewController.swift
//  MyWallet
//
//  Created by congphuong on 11/22/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.isNavigationBarHidden = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "MyWallet"
        
        setupView()
        
    }
    
    func createButton(image: UIImage, label: String)->UIButton {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setTitle(label, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        let imgSize = button.imageView?.image?.size
        let text = button.titleLabel?.text
        let font = button.titleLabel?.font
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imgSize!.width, -imgSize!.height, 0.0)
        let titleString = NSString(string: text!)
        let titleSize = titleString.size(withAttributes: [NSAttributedStringKey.font: font!])
        button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0.0, 0.0, -titleSize.width)
        let edgeOffset = abs(titleSize.height - imgSize!.height) / 2.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
        
        return button
    }
    
    @objc func btQRClick(){
        let vc2 = VC2()
        //let stb = UIStoryboard(name: "Main", bundle: nil)
        //let vc2 = stb.instantiateViewController(withIdentifier: "VerifyVC") as? VerifyVC
        
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    @objc func btHistoryClick(){
        let layout = UICollectionViewFlowLayout()
        let vc2 = HistoryVC(collectionViewLayout: layout)
        //vc2.histories = histories
        //vc2.view.backgroundColor = .white
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    @objc func btWalletClick(){
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "WalletVC") as? WalletVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func btGenerateQRClick(){
        let vc2 = GenerateQRVC()
        vc2.view.backgroundColor = .white
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    func setupView() {
        let btQR = createButton(image: #imageLiteral(resourceName: "barcode-reader-50"), label: "Quét")
        btQR.addTarget(self, action: #selector(btQRClick), for: .touchUpInside)
        let btHistory = createButton(image: #imageLiteral(resourceName: "activity-history-50"), label: "Lịch sử")
        btHistory.addTarget(self, action: #selector(btHistoryClick), for: .touchUpInside)
        let btGenerateQR = createButton(image: #imageLiteral(resourceName: "qr-code-50"), label: "Tạo code")
        btGenerateQR.addTarget(self, action: #selector(btGenerateQRClick), for: .touchUpInside)
        let btWallet = createButton(image: #imageLiteral(resourceName: "wallet-50"), label: "Tài khoản")
        btWallet.addTarget(self, action: #selector(btWalletClick), for: .touchUpInside)
        
        let stackView1 = UIStackView(arrangedSubviews: [btQR,btHistory])
        let stackView2 = UIStackView(arrangedSubviews: [btGenerateQR,btWallet])
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.layoutMargins = UIEdgeInsetsMake(30.0, 0.0, 0.0, 0.0)
        stackView1.isLayoutMarginsRelativeArrangement = true
        
        
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        
        let viewV = UIStackView(arrangedSubviews: [stackView1, stackView2])
        viewV.distribution = .fillEqually
        viewV.axis = .vertical
        viewV.spacing = 20
        viewV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewV)
        NSLayoutConstraint.activate([
            viewV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


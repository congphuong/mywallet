//
//  VC2.swift
//  MyWallet
//
//  Created by congphuong on 11/24/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit

class VC2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "QR code"
        //setupView()
    }
    
    func setupView() {
        let viewV = UIStackView()
        viewV.distribution = .fillEqually
        viewV.axis = .vertical
        viewV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewV)
        NSLayoutConstraint.activate([
            viewV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

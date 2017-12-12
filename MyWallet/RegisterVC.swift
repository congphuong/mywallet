//
//  RegisterVC.swift
//  MyWallet
//
//  Created by congphuong on 12/12/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit
class RegisterVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtIdentify: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    @IBAction func cancelClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

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
        cancel()
    }
    
    @IBAction func btRegisterClick(_ sender: Any) {
        API.register(username: txtUsername.text!, password: txtPassword.text!, identify: txtIdentify.text!, name: txtName.text!){
            (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                self.cancel()
            }
        }
        }
    }
    
    func cancel(){
        navigationController?.popViewController(animated: true)
    }
    
}

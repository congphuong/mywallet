//
//  LoginVC1.swift
//  MyWallet
//
//  Created by congphuong on 12/12/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit
class LoginVC1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func loginClick(_ sender: Any) {
        //API.login(username: <#T##String#>, password: <#T##String#>, completionHandler: <#T##(Data?) -> Void#>)
        API.login(username: txtUsername.text!, password: txtPassword.text!) { (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            print("ok!")
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                let auth = Auth(json: responseJSON)
                print(auth!)
            }
        }
    }
    
}

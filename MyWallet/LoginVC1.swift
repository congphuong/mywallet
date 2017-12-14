//
//  LoginVC1.swift
//  MyWallet
//
//  Created by congphuong on 12/12/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit
class LoginVC1: UIViewController {
    var auth: Auth?
    var isLogin = false {
        didSet{
            if isLogin {
                DispatchQueue.main.async {
                    self.loginSucess()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func loginClick(_ sender: Any) {
        
        API.login(username: txtUsername.text!, password: txtPassword.text!) { (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
            
            print("ok!")
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                if((responseJSON["status"]) == nil){
                    print("test")
                    self.auth = Auth(json: responseJSON)
                    UserDefaults.standard.set(self.auth?.token, forKey: "token")
                    UserDefaults.standard.set(self.auth?.username, forKey: "username")
                    UserDefaults.standard.set(self.auth?.id, forKey: "id")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    self.isLogin = true
                }
            }
            }
            
        }
    }
    
    func loginSucess(){
        let vc = ViewController()
        vc.view.backgroundColor = .white
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
}

//
//  LoginVC.swift
//  MyWallet
//
//  Created by congphuong on 12/11/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit
class LoginVC: UIViewController {
    let host:String = "http://localhost:8080"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }
    
    let txtUsername: UITextField = {
        let tf = UITextField()
        tf.placeholder = "username"
        tf.layer.cornerRadius = 10
        
        
        return tf
    }()
    let txtPassword: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let btLogin: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("login", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(login), for: .touchUpInside)
        return bt
        }()
    
    @objc func login(){
        print("Login click")
        var url = URLRequest(url: URL(string: host + "/auth")!)
        //let url1 = URL(string: host)
        url.httpMethod = "POST"
        url.addValue("application/json", forHTTPHeaderField: "Content-Type")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        let json: [String: Any] = ["username": txtUsername.text!,
                                   "password": txtPassword.text!]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        url.httpBody = jsonData
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            //print("ok!")
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
        }.resume()
    }
    
    func setupLoginView(){
        view.addSubview(txtUsername)
        view.addSubview(txtPassword)
        view.addSubview(btLogin)
        view.addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: txtUsername)
        view.addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: txtPassword)
        view.addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: btLogin)
        view.addConstraintsWithFormat(format: "V:|-100-[v0(40)]-10-[v1(40)]-10-[v2(40)]", views: txtUsername, txtPassword,btLogin)
    }
}

struct Auth {
    var id: Int
    var username: String
    var token: String
    
    init?(json: [String: Any]) {
        guard let token = json["token"] as? String, let user = json["user"] as? [String: Any] else{
            return nil
        }
        self.id = (user["machucvu"] as? Int)!
        self.username = (user["username"] as? String)!
        self.token = token
    }
    
}

//
//  WalletVC.swift
//  MyWallet
//
//  Created by congphuong on 11/25/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit

class WalletVC: UIViewController {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var amount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Tài khoản"
        if let u = UserDefaults.standard.string(forKey: "username") {
            username.text = u
            loadDetail(username: u)
        }
    }
    func loadDetail(username: String){
        API.getDetail(username: username){
            (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
            
            print("ok!")
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                guard let status = responseJSON["status"] as? Int else {
                DispatchQueue.main.async {
                    self.username.text = responseJSON["nameCustomer"] as? String
                    let a:Int = responseJSON["totalMoney"] as! Int
                    self.amount.text = String(a) + " vnd"
                }
                    return
                }
                
                
            }
            
        }
        }
    }
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.set(false, forKey: "isLogin")
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = stb.instantiateViewController(withIdentifier: "login") as! LoginVC1
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = UINavigationController(rootViewController: loginVC)
    }
}

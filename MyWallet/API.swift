//
//  API.swift
//  MyWallet
//
//  Created by congphuong on 12/12/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import Foundation
class API {
    static let host:String = "http://localhost:8080"
    static func login(username: String, password: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> Swift.Void {
        print("Login click")
        var url = URLRequest(url: URL(string: host + "/auth")!)
        //let url1 = URL(string: host)
        url.httpMethod = "POST"
        url.addValue("application/json", forHTTPHeaderField: "Content-Type")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        let json: [String: Any] = ["username": username,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        url.httpBody = jsonData
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            //print("ok!")
            completionHandler(data, response, error)
            }.resume()
    }
    
    static func register(username: String, password: String,identify: String, name: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> Swift.Void {
        print("register click")
        var url = URLRequest(url: URL(string: host + "/register")!)
        //let url1 = URL(string: host)
        url.httpMethod = "POST"
        url.addValue("application/json", forHTTPHeaderField: "Content-Type")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        let json: [String: Any] = ["userName": username,
                                   "password": password,
                                   "identify":identify,
                                   "firstName":name]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        url.httpBody = jsonData
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            //print("ok!")
            completionHandler(data, response, error)
            }.resume()
    }
    
    static func getDetail(username: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> Swift.Void {
        var url = URLRequest(url: URL(string: host + "/customer/detail")!)
        url.httpMethod = "GET"
        let token = UserDefaults.standard.string(forKey: "token")
        url.addValue(token!, forHTTPHeaderField: "Authorization")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            
            completionHandler(data, response, error)
            }.resume()
    }
    
    static func getHistory(numpage: Int, offset: Int, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> Swift.Void {
        let urls = host + "/customer/history/\(numpage)/\(offset)" ;
        
        var url = URLRequest(url: URL(string: urls)!)
        url.httpMethod = "GET"
        let token = UserDefaults.standard.string(forKey: "token")
        url.addValue(token!, forHTTPHeaderField: "Authorization")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            completionHandler(data, response, error)
            }.resume()
    }
    
    static func encode(exchangMoney: Double, note: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> Swift.Void {
        var url = URLRequest(url: URL(string: host + "/customer/encodeQRImage")!)
        //let url1 = URL(string: host)
        url.httpMethod = "POST"
        let token = UserDefaults.standard.string(forKey: "token")
        url.addValue(token!, forHTTPHeaderField: "Authorization")
        url.addValue("application/json", forHTTPHeaderField: "Content-Type")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        let json: [String: Any] = ["exchangeMoney": exchangMoney,
                                   "note": note]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        url.httpBody = jsonData
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            //print("ok!")
            completionHandler(data, response, error)
            }.resume()
    }
    
    static func decode(code: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> Swift.Void {
        var url = URLRequest(url: URL(string: host + "/customer/decodeQRImage")!)
        //let url1 = URL(string: host)
        url.httpMethod = "POST"
        let token = UserDefaults.standard.string(forKey: "token")
        url.addValue(token!, forHTTPHeaderField: "Authorization")
        url.addValue("application/json", forHTTPHeaderField: "Content-Type")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        let json: [String: Any] = ["code": code]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        url.httpBody = jsonData
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            //print("ok!")
            completionHandler(data, response, error)
            }.resume()
    }
    
    static func tranferqr(code: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> Swift.Void {
        var url = URLRequest(url: URL(string: host + "/customer/transferqr")!)
        //let url1 = URL(string: host)
        url.httpMethod = "POST"
        let token = UserDefaults.standard.string(forKey: "token")
        url.addValue(token!, forHTTPHeaderField: "Authorization")
        url.addValue("application/json", forHTTPHeaderField: "Content-Type")
        url.addValue("application/json", forHTTPHeaderField: "Accept")
        let json: [String: Any] = ["code": code]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        url.httpBody = jsonData
        
        URLSession.shared.dataTask(with: url) { (data,response, error) in
            //print("ok!")
            completionHandler(data, response, error)
            }.resume()
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

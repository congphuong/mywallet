//
//  API.swift
//  MyWallet
//
//  Created by congphuong on 12/12/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import Foundation
class API {
    static let host:String = "http://192.168.1.19:8080"
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
        let json: [String: Any] = ["username": username,
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
    
    
}

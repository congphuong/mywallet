//
//  History.swift
//  MyWallet
//
//  Created by congphuong on 11/27/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import Foundation

struct History {
    var id:String?
    var type:String?
    var amount:Double?
    
    init(id:String, type:String, amount:Double){
        self.id = id
        self.type = type
        self.amount = amount
    }
}

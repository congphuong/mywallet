//
//  History.swift
//  MyWallet
//
//  Created by congphuong on 11/27/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import Foundation

struct History {
    var id:Int?
    var type:Int?
    var amount:Double?
    var timestamp:Double
    
    init(id:Int, type:Int, amount:Double, time:Double){
        self.id = id
        self.type = type
        self.amount = amount
        self.timestamp = time
    }
}

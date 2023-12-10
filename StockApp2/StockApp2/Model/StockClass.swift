//
//  StockClass.swift
//  StockApp2
//
//  Created by 姚宗辉 on 11/12/23.
//

import Foundation
import RealmSwift

class StockClass:Object{
    @objc dynamic var symbol:String = ""
    @objc dynamic var price: Float = 0.0
    @objc dynamic var companyName:String = ""
    @objc dynamic var companyDescription:String = ""
    
    override static func primaryKey() -> String? {
        return "symbol"
    }
}

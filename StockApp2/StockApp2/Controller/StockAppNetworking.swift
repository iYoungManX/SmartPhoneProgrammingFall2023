//
//  StockAppNetworking.swift
//  StockApp2
//
//  Created by 姚宗辉 on 11/12/23.
//


import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit


func getAllStockQuotes(symbols:[String])-> Promise<[StockClass]>{
    var promises: [Promise<StockClass>] = []
    for i in 0 ... symbols.count - 1{
        promises.append( getStockInfoShort(symbol: symbols[i]))
    }
    return when(fulfilled: promises)
}


func getStockInfoShort(symbol: String) ->Promise<StockClass>{
    return Promise<StockClass>{ seal -> Void in
        let url = "\(baseURL)profile/\(symbol)?apikey=\(apiKey)"

        AF.request(url).responseJSON { response in
            if(response.error != nil){
                seal.reject(response.error!)
                print("cannpt get data!!!!")
                return
            }
            // We have valid data here

            guard let rawData = response.data else {return}
            guard let jsonArray = JSON(rawData).array else {return}
            guard let stock = jsonArray.first else {return}

            let symbol = stock["symbol"].stringValue
            let price = stock["price"].floatValue
            
            let stockClass = StockClass()
            stockClass.symbol = symbol
            stockClass.price = price
            seal.fulfill(stockClass)
        }
    }
}

func getStockInfo(symbol: String) ->Promise<StockClass>{
    return Promise<StockClass>{
        seal -> Void in 
        let url = "\(baseURL)profile/\(symbol)?apikey=\(apiKey)"


        AF.request(url).responseJSON { response in
            if(response.error != nil){
                seal.reject(response.error!)
                return

            }

            // We have valid data here

            guard let rawData = response.data else {return}

            guard let jsonArray = JSON(rawData).array else {return}

            guard let stock = jsonArray.first else {return}



            let symbol = stock["symbol"].stringValue

            let price = stock["price"].floatValue

            let companyName = stock["companyName"].stringValue

            let description = stock["description"].stringValue


            let stockClass = StockClass()

            stockClass.symbol = symbol

            stockClass.price = price

            stockClass.companyName = companyName

            stockClass.companyDescription = description
         
            seal.fulfill(stockClass)


        }
    }
}

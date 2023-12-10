//
//  ViewController.swift
//  StockApp2
//
//  Created by 姚宗辉 on 10/21/23.
//

import UIKit
import RealmSwift
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var stockArray = [StockClass]()
//    var stockArrayShort:[StockQuoteShort] = [StockQuoteShort]()

 
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadStockValues()
    }

    func loadStockValues(){
        // read value from local database
        do{
            stockArray = [StockClass]()
            let realm = try Realm()
            let stocks = realm.objects(StockClass.self)
//            print(stocks)
            if stocks.isEmpty{
                return
            }
//            print(stocks)
            var stockSymbols:[String] = []
            for stock in stocks{
                stockSymbols.append(stock.symbol)
            }
        
   
//            stockArrayShort = [StockQuoteShort]()
            getAllStockQuotes(symbols: stockSymbols)
                .done{ stockQuotes in
                    for stockQuote in stockQuotes{
                        let stockClass = StockClass()
                        stockClass.symbol  = stockQuote.symbol
                        stockClass.price  = stockQuote.price
                        self.stockArray.append(stockClass)
                    }
//                    print(self.stockArray)
                    self.tblView.reloadData()
                }
           
        }
        catch{
            print("Error in reading from Realm \(error)")
        }
    }
        

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let symbol = stockArray[indexPath.row].symbol
        let price = String(format: "%.2f", stockArray[indexPath.row].price)
        cell.textLabel?.text = "\(symbol): \(price) $"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteFromRealmDB(stockArray[indexPath.row])
            stockArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func deleteFromRealmDB(_ stock: StockClass){
        do{
         
            let realm = try Realm()
            try realm.write{
                let predicate = NSPredicate(format: "symbol == %@", stock.symbol)
                if let stockToDelete = realm.objects(StockClass.self).filter(predicate).first{
                    realm.delete(stockToDelete)
                }
            }
        }
        catch{
            print("Error in reading from Realm \(error)")
        }
    }

}

//
//  AddStockViewController.swift
//  StockApp2
//
//  Created by 姚宗辉 on 10/21/23.
//

import UIKit

import Alamofire
import SwiftyJSON
import RealmSwift
class AddStockViewController: UIViewController {

  
    @IBOutlet weak var txtStock: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func addStockAction(_ sender: Any) {
        guard let stockSymbol = txtStock.text else {return}
        
        let stock = getStockInfo(symbol: stockSymbol)
        stock.done{ stockClass in
            print(stockClass)
            do{
                let realm = try Realm()
//                print(realm.configuration.fileURL)
                try realm.write({
                    realm.add(stockClass, update: .modified )
                })
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("Error in a dding data to the Realm DB");
            }
        
        }
        .catch{ error in
            print("Unable to get stock value \(error)")
        }
   
    }
}

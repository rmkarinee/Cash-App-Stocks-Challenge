//
//  StockViewModel.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-13.
//

import Foundation

class StockViewModel {
    
    var serviceManager = ServiceManager()
    
    var stockList: [StockItem] = []
    
    func priceConvert(_ price: Int) -> String {
        let priceConvert = Float(price)/100
        return "Price: \(String(priceConvert))"
    }
    
    func handleRequestSuccess(data: StockModel) {
        stockList = data.stocks
    }
}

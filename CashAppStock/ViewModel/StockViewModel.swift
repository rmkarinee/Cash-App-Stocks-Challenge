//
//  StockViewModel.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-13.
//

import Foundation

protocol StockViewModelDelegate {
    func didFinishRequest()
}

class StockViewModel {
    
    var serviceManager = ServiceManager()
    var stockItems = [StockItem]()
    var delegate: StockViewModelDelegate?
    
    func priceConvert(_ price: Int) -> String {
        let priceConvert = Float(price)/100
        return "Price: \(String(priceConvert))"
    }
    
    func requestStocks() {
        let service = StocksService.success
        let session = URLSessionProvider()
        session.request(type: StockModel.self, url: service) { (result) in
            switch result {
            case .success(let result):
                self.fetchSucessData(data: result)
                self.delegate?.didFinishRequest()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchSucessData(data: StockModel) {
        stockItems = data.stocks
    }
    
    func numberOfItens() -> Int {
        return stockItems.count
    }
}

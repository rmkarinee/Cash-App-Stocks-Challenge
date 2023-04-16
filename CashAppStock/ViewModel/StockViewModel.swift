//
//  StockViewModel.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-13.
//

import Foundation

protocol StockViewModelDelegate: AnyObject {
    func didFinishRequest()
}

class StockViewModel {
    
    var stockItems = [StockItem]()
    public weak var delegate: StockViewModelDelegate?
    
    func priceConvert(_ price: Int) -> String {
        let priceConvert = Float(price)/100
        return String(priceConvert)
    }
    
    func convertToDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY hh:mm"
        return dateFormatter.string(from: date)
    }
    
    func requestStocks() {
        let service = StocksService.success
        let session = URLSessionProvider()
        session.request(type: StockModel.self, url: service) { (result) in
            switch result {
            case .success(let result):
                self.stockItems = result.stocks
                self.delegate?.didFinishRequest()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func numberOfItens() -> Int {
        return stockItems.count
    }
}

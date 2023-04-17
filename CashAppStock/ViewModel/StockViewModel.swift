//
//  StockViewModel.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-13.
//

import Foundation

protocol StockViewModelDelegate: AnyObject {
    func didFinishRequest(isEmpty: Bool)
    func errorAlert()
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
    
    func numberOfItens() -> Int {
        return stockItems.count
    }
}


// MARK: - Requests
extension StockViewModel {
    
    func requestStocks() {
        let service = StocksService.success
        let session = URLSessionProvider()
        session.request(type: StockModel.self, url: service) { (result) in
            switch result {
            case .success(let result):
                if result.stocks.isEmpty {
                    self.delegate?.didFinishRequest(isEmpty: true)
                } else {
                    self.stockItems = result.stocks
                    self.delegate?.didFinishRequest(isEmpty: false)
                }
                
            case .failure(let error):
                self.delegate?.errorAlert()
                print(error.localizedDescription)
            }
        }
    }

    func requestFailStocks() {
        let service = StocksService.error
        let session = URLSessionProvider()
        session.request(type: StockModel.self, url: service) { (result) in
            switch result {
            case .success(let result):
                if result.stocks.isEmpty {
                    self.delegate?.didFinishRequest(isEmpty: true)
                } else {
                    self.stockItems = result.stocks
                    self.delegate?.didFinishRequest(isEmpty: false)
                }
                
            case .failure(let error):
                self.delegate?.errorAlert()
                print(error.localizedDescription)
            }
        }
    }
    
    func requestEmptyStocks() {
        let service = StocksService.empty
        let session = URLSessionProvider()
        session.request(type: StockModel.self, url: service) { (result) in
            switch result {
            case .success(let result):
                if result.stocks.isEmpty {
                    self.delegate?.didFinishRequest(isEmpty: true)
                } else {
                    self.stockItems = result.stocks
                    self.delegate?.didFinishRequest(isEmpty: false)
                }
    
            case .failure(let error):
                self.delegate?.errorAlert()
                print(error.localizedDescription)
            }
        }
    }
    
}

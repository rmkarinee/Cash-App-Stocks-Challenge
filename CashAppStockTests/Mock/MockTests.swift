//
//  MockTests.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-15.
//

import Foundation
@testable import CashAppStock

struct MockTests {
    func createStocksJson() -> [StockItem] {
        var stockList: [StockItem] = []
        
        stockList.append(StockItem(ticker: "TWTR",
                                   name: "Twitter, Inc.",
                                   currency: "USD",
                                   current_price_cents: 3833,
                                   quantity: nil,
                                   current_price_timestamp: 1636657688))
        stockList.append(StockItem(ticker: "^GSPC",
                                   name: "S&P 500",
                                   currency: "USD",
                                   current_price_cents: 318157,
                                   quantity: 25,
                                   current_price_timestamp: 1636657688))
        stockList.append(StockItem(ticker: "RUNINC",
                                   name: "Runners Inc.",
                                   currency: "USD",
                                   current_price_cents: 3614,
                                   quantity: 5,
                                   current_price_timestamp: 1636657688))
        stockList.append(StockItem(ticker: "BAC",
                                   name: "Bank of America Corporation",
                                   currency: "USD",
                                   current_price_cents: 2393,
                                   quantity: 10,
                                   current_price_timestamp: 1636657688))
        return stockList
    }
}

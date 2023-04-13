//
//  StockModel.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import Foundation

struct StockModel: Codable {
    let stocks: [StockItem]
}

struct StockItem: Codable {
    let ticker: String
    let name: String
    let currency: String
    let current_price_cents: Int
    let quantity: Int?
    let current_price_timestamp: Int
}

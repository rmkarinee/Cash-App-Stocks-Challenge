//
//  StocksService.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-14.
//

import Foundation

protocol Service {
    var baseURL: URL { get }
}

enum StocksService: Service {
    
    case success
    case empty
    case error
    
    var baseURL: URL {
        switch self {
        case .success:
            if let url = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json") {
                return url
            }
        case .empty:
            if let url = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_empty.json") {
                return url
            }
        case .error:
            if let url = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_malformed.json") {
                return url
            }
        }
        return URL(fileURLWithPath: "")
    }
}

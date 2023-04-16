//
//  AlertConfig.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-16.
//

import Foundation

enum AlertType {
    case emptyAlert
    case errorAlert
    
    func getMessage() -> AlertMessage {
        switch self {
        case .emptyAlert:
            return AlertMessage(title: "Attention", message: "There are no items in the Stock", buttonLabel: "OK")
        case .errorAlert:
            return AlertMessage(title: "Sorry", message: "Something went wrong", buttonLabel: "Try Again")
        }
    }
}

struct AlertMessage {
    var title: String
    var message: String
    var buttonLabel: String
}

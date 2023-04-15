//
//  Provider.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-14.
//

import Foundation
protocol Provider {
    func request<T: Decodable>(
        type: T.Type, url: Service, completion: @escaping (Result<T, Error>) -> Void)
}

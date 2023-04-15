//
//  URLSessionExtension.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-14.
//

import Foundation
extension URLSession {

    func dataTask(
        with url: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

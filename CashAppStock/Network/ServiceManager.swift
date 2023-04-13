//
//  ServiceManager.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import Foundation

class ServiceManager {

    func requestStock(completion: @escaping (StockModel) -> Void){
        if let url = URL(string: ServicesConstants().url) {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                
                if error != nil {
                    print("An request error occurred: \(String(describing: error))")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Status Code Error : \(String(describing: response))")
                    return
                }
                
                if let safeData = data {
                    do {
                        let json = try JSONDecoder().decode(StockModel.self, from: safeData)
                        completion(json)
                        
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            })
            task.resume()
        }
        
    }
}

struct ServicesConstants {
    ///  Success URL
    let url = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    ///  Empty URL
//    let url = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_empty.json"
    ///  Error URL
//    let url = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_malformed.json"
}

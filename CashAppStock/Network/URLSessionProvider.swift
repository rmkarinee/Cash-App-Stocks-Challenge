//
//  URLSessionProvider.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-14.
//

import Foundation
final class URLSessionProvider: Provider {
    
    private var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(
        type: T.Type, url: Service, completion: @escaping (Result<T, Error>) -> Void) {
            
            let request = URLRequest(url: url.baseURL)
            
            let task = self.session.dataTask(with: request) { (result) in
                self.handleResult(result: result, completion: completion)
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                task.resume()
            }
        }
    
    private func handleResult<T: Decodable>(
        result: Result<(URLResponse, Data), Error>, completion: (Result<T, Error>) -> Void) {
            
            switch result {
            case .failure(let error):
                print("\n\n\nerror\(error)\n\n\n")
                completion(.failure(error))
            case .success((let response, let data)):
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(NetworkError.noJSONData))
                }
                print("RESPONSE: \(httpResponse)")
                if let dataString = String(bytes: data, encoding: .utf8) {
                    print("DATA: \(dataString)")
                }
                switch httpResponse.statusCode {
                case 200...299:
                    let decoder = JSONDecoder()
                    
                    if let newdata = data as? T {
                        completion(.success(newdata))
                        return
                    }
                    do {
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        print("ERROR DECODE: \(error)")
                        completion(.failure(NetworkError.unknown))
                    }
                    
                default:
                    completion(.failure(NetworkError.unknown))
                }
            }
            
        }
}

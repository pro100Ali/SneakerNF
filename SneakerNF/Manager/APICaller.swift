//
//  APICaller.swift
//  StrongTeam
//
//  Created by Али  on 17.05.2023.
//

import Foundation


class APICaller {
    static let shared = APICaller()

    func handleRequest(completion: @escaping (Result<[Sneaker], Error>) -> Void) {
        
        let urlString = "http://localhost:8088/sneakers/getAll"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                print(data)
                do {
                    let articles = try decoder.decode([Sneaker].self, from: data)
                    completion(.success(articles))
                    
                } catch let error {
                    print("Error was \(error)")
                    completion(.failure(error))
                }
            }
            
            if let error = error {
                print("ERRRRROOR \(error)")
            }
            
        }
        task.resume()
        
    }
    
}

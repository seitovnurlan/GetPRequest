//
//  ApiManager.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 7/4/23.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
//    let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-03-28&to=2023-03-28&sortBy=popularity&apiKey=60370b214d0b4cf48e72818fd383a586"
    
    func getRequest(completion: @escaping (Result<DataModel, Error>) -> Void) {
       
        guard let url = URL(string: "https://dummyjson.com/products") else {return}
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
 
            guard let data = data else {return}
            
            do {
                let model = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func postRequest(id: Int, title: String, completion: @escaping (Result<Int, Error>) -> Void) {
       
        guard let url = URL(string: "https://dummyjson.com/products/add") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let products = DataModel(products: [.init(id: id, title: title)], total: 1, skip: 1, limit: 1)
        request.httpBody = try? JSONEncoder().encode(products)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            
            if let error {
                completion(.failure(error))
            } else {
                completion(.success((response.statusCode)))
            }
        }
        task.resume()
    }
}

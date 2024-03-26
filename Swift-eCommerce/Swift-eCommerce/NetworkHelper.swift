//
//  NetworkHelper.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 3/20/24.
// url session call api

import Foundation
class  NetworkHelper{
    let productURL = "https://fakestoreapi.com/products"
    //                    [product] comefrom modal file
    func getAllProducts(completion: @escaping(Result<[Product]?,Error>)->Void){
     let url = URL(string: productURL)
      var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error{
                completion(.failure(error))
            }else{
                if let data{
//                    [product] comefrom modal file
                    let parseData = try? JSONDecoder().decode([Product].self, from: data)
                    completion(.success(parseData))
                }
            }
        }
        task.resume()
    }
}

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
//                    [product] comefrom modal file - all product
                    let parseData = try? JSONDecoder().decode([Product].self, from: data)
                    completion(.success(parseData))
                }
            }
        }
        task.resume()//for execute api
    }
    //call api for catergorycell on homepage
    func getCategories(completion: @escaping(Result<[String]?,Error>)->Void){
        let catergoryURL = "https://fakestoreapi.com/products/categories"
        let url = URL(string: catergoryURL)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error{
                completion(.failure(error))
            }else{
                if let data{
                    //below need to modify --product catergoty --look at fakeproductapi/catergory
                    let json = try? JSONSerialization.jsonObject(with: data) as? [String]
                    
                    completion(.success(json))
               
                }
            }
        }
        task.resume()
        //all network helper--all page that have api-- have task.resume()
    }
}

//
//  NetworkService.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import Foundation


class NetworkService{
    
    static let shared = NetworkService()
    
    private let baseURL = "https://www.alphavantage.co"
    
    private let path = "/query"
    
    private let apiKey = "LC0HKG8WYC7FPSY"
    
    private let timeInterval = Constants.shared.getStringFromUserDefaults(key: .intarval)
    
    
    func getURL(function: NetworkFunctions, parameter: [String: Any]) -> URL?{
    
        var urlString = baseURL + path + "?" + "function=\(function.rawValue)&"
        for (key,value) in parameter {
            urlString = urlString + "\(key)=\(value)&"
        }
        return URL(string: urlString + "apikey=\(self.apiKey)")
    }
    
    /**
     Use this generic function to load data form given URL
     
     - Parameter url: Webservices URL
     result: Based on response it pass the result
     - Returns: nil
     */
    func getData<T: NSDictionary>(with url: URL, result: @escaping (Result<T, Error>) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            do{
                if let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    result(.success(jsonDic as! T))
                }
            }catch{
                result(.failure(error))
            }
        }.resume()
    }
    
    
}

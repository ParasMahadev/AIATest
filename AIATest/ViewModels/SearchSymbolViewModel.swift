//
//  SearchSymbolViewModel.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import Foundation

class SearchSymbolViewModel: NSObject {
    
    func getSymbolData(keyword: String,completion: @escaping ([SymbolDetails]?, String?) -> Void){
        
        let paramaters = ["keywords": keyword]
        guard let url = NetworkService.shared.getURL(function: .symbolSearch, parameter: paramaters ) else {return}
        NetworkService.shared.getData(with: url) { Result in
            switch Result{
            case .success(let dic):
                if let result = self.mapSymbolData(dic: dic){
                    completion(result, nil)
                }else{
                    if let errorMessage = dic["Error Message"] as? String{
                        completion(nil, errorMessage)
                    }else{
                        completion(nil,"Something went wrong")
                    }
                }
            case .failure(let error):
                completion(nil,error.localizedDescription)
            }
        }
    }
    
    private func mapSymbolData(dic: NSDictionary) -> [SymbolDetails]?{
        var result = [SymbolDetails]()
        if let bestMatches = dic["bestMatches"] as? [[String: Any]]{
            for item in bestMatches{
                result.append(SymbolDetails(dictionary: item))
            }
        }
        return result
    }
    
    
    
    
    
}

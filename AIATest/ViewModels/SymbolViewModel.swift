//
//  SymbolViewModel.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import Foundation


class SymbolViewModel: NSObject {
    
    
    func getIntradayData(timeInterval: TimeIntervals,symbol: String,completion: @escaping (intradayDataList?, String?) -> Void){
        let paramaters = ["symbol":symbol,
                          "interval": timeInterval.rawValue]
        guard let url = NetworkService.shared.getURL(function: .timeSeriesIntraday, parameter: paramaters ) else {return}
        NetworkService.shared.getData(with: url) { Result in
            switch Result{
            case .success(let dic):
                if let result = self.mapIntradayData(timeIntervalKey: timeInterval, dic: dic), result.count > 0{
                    completion(result,nil)
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
    
    private func mapIntradayData(timeIntervalKey: TimeIntervals,dic: NSDictionary) -> intradayDataList?{
    
        var result = [IntradayData]()
        if let timeSeries = dic["Time Series (\(timeIntervalKey.rawValue))"] as? [String: Any]{
            for (key, value) in timeSeries{
                guard let valueInDic = value as? [String: Any] else {
                    return nil
                }
                result.append(IntradayData(date: key, dictionary: valueInDic)!)
            }
        }
        return result
    }
    
    
    
    
}

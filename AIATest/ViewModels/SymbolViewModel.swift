//
//  SymbolViewModel.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import Foundation


class SymbolViewModel: NSObject {
    
    
    func getDataIntradayData(timeInterval: TimeIntervals,symbol: String,completion: @escaping (intradayDataList?) -> Void){
        let paramaters = ["symbol":symbol,
                          "interval": timeInterval.rawValue]
        guard let url = NetworkService.shared.getURL(function: .timeSeriesIntraday, parameter: paramaters ) else {return}
        NetworkService.shared.getData(with: url) { Result in
            switch Result{
            case .success(let dic):
                if let result = self.getIntradayData(timeIntervalKey: timeInterval, dic: dic){
                    completion(result)
                }else{
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getIntradayData(timeIntervalKey: TimeIntervals,dic: NSDictionary) -> intradayDataList?{
    
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

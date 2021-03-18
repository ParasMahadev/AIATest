//
//  NetworkService.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import Foundation

enum TimeIntervals: String {
    case oneMin = "1min"
    case fiveMin = "5min"
    case fifteenMin = "15min"
    case thirtyMin = "30Min"
    case sixtyMin = "60Min"
}

enum NetworkFunctions: String {
    case timeSeriesIntradat = "TIME_SERIES_INTRADAY"
    case symbolSearch = "SYMBOL_SEARCH"
    case timeSeriesDailyAdjusted = "TIME_SERIES_DAILY_ADJUSTED"
}

class NetworkService{
    
    var baseURL = "https://www.alphavantage.co"
    
    var path = "/query"
    
    var apiKey = "LC0HKG8WYC7FPSYY"
    
    
    /**
    Use this generic function to load data form given URL

    - Parameter url: Webservices URL
                result: Based on response it pass the result
    - Returns: nil
    */
    func getIntradayData(with func: NetworkFunctions, timeInterval: TimeIntervals,  result: @escaping () -> Void){
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
            guard let channelResponseModel = try? JSONDecoder().decode(T.self, from:data) else {
                result(.failure(error!))
                return
            }
            result(.success(channelResponseModel))
        }.resume()
    }
    
    
}

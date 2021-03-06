//
//  Contstants.swift
//  AIATest
//
//  Created by Paras Navadiya on 20/03/21.
//

import Foundation

enum Outputsize: String {
    case compact
    case full
}

enum UserDefaultsKeys: String {
    case intarval
    case outputsize
}

enum CellIdentifieres: String {
    case IntradayHeaderTableViewCell = "IntradayHeaderTableViewCell"
    case IntradayTableViewCell = "IntradayTableViewCell"
    case SearchSymbolTableViewCell = "SearchSymbolTableViewCell"
    case CompareTableViewCell = "CompareTableViewCell"
}

enum TimeIntervals: String {
    case oneMin = "1min"
    case fiveMin = "5min"
    case fifteenMin = "15min"
    case thirtyMin = "30Min"
    case sixtyMin = "60Min"
}

enum NetworkFunctions: String {
    case timeSeriesIntraday = "TIME_SERIES_INTRADAY"
    case symbolSearch = "SYMBOL_SEARCH"
    case timeSeriesDailyAdjusted = "TIME_SERIES_DAILY_ADJUSTED"
}


class Constants{
    
    static let shared = Constants()
        
     func setStringToUserDefaults(key: UserDefaultsKeys, value: String){
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
     func getStringFromUserDefaults(key: UserDefaultsKeys) -> String{
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    
    func storeStringToKeyChain(key: String, value: String){
        let data = value.data(using: .utf8) ?? Data()
        let _ = KeyChain.save(key: key, data: data)
    }
    
    
    func getStringFromKeyChain(key: String) -> String{
        if let receivedData = KeyChain.load(key: key) {
            return String(decoding: receivedData, as: UTF8.self)
        }
        return ""
    }
}

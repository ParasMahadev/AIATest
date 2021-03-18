//
//  IntradayData.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import Foundation


struct IntradayData {
    var date: String?
    let the1Open, the2High, the3Low, the4Close, the5Volume: String?
}

extension IntradayData{
    init (dictionary: [String: Any]){
        self.the1Open = dictionary["1. open"] as? String
        self.the2High = dictionary["2. high"] as? String
        self.the3Low = dictionary["3. low"] as? String
        self.the4Close = dictionary["4. close"] as? String
        self.the5Volume = dictionary["5. volume"] as? String
    }
    
    init?(date: String, dictionary: [String: Any]){
        self.date = date
        self.the1Open = dictionary["1. open"] as? String
        self.the2High = dictionary["2. high"] as? String
        self.the3Low = dictionary["3. low"] as? String
        self.the4Close = dictionary["4. close"] as? String
        self.the5Volume = dictionary["5. volume"] as? String
    }
}

typealias intradayDataList = [IntradayData]

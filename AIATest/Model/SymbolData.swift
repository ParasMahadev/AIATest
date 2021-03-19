//
//  SymbolData.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import Foundation

struct SymbolDetails {
    var symbol: String?
    var name: String?
    var type: String?
    var matchScore: String?
}

extension SymbolDetails{
    init (dictionary: [String: Any]){
        self.symbol = dictionary["1. symbol"] as? String
        self.name = dictionary["2. name"] as? String
        self.type = dictionary["3. type"] as? String
        self.matchScore = dictionary["9. matchScore"] as? String
    }

}

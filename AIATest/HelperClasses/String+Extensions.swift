//
//  String+Extensions.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import Foundation


extension String{
    
    func getDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }
}

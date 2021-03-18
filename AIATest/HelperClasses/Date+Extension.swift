//
//  Date+Extension.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import Foundation


extension Date {
    
    func getString(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

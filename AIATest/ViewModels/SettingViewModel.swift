//
//  SettingViewModel.swift
//  AIATest
//
//  Created by Paras Navadiya on 20/03/21.
//

import Foundation


class SettingViewModel: NSObject{
    
    func getTimeIntervalIndex() -> Int{
        let timeInterval = Constants.shared.getStringFromUserDefaults(key: .intarval)
        switch timeInterval {
        case TimeIntervals.oneMin.rawValue:
            return 0
        case TimeIntervals.fiveMin.rawValue:
            return 1
        case TimeIntervals.fifteenMin.rawValue:
            return 2
        case TimeIntervals.thirtyMin.rawValue:
            return 3
        case TimeIntervals.sixtyMin.rawValue:
            return 4
        default:
            return 0
        }
    }
    
    func getOutputsizeIndex() -> Int{
        let outputSizee = Constants.shared.getStringFromUserDefaults(key: .outputsize)
        switch outputSizee {
        case Outputsize.compact.rawValue:
            return 0
        case Outputsize.full.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    
    func getTimeInterval(index: Int) -> TimeIntervals{
        switch index{
        case 0:
            return .oneMin
        case 1:
            return .fiveMin
        case 2:
            return .fifteenMin
        case 3:
            return .thirtyMin
        case 4:
            return .sixtyMin
        default:
            return .oneMin
        }
    }
    
    func getOutputsize(index: Int) -> Outputsize {
        switch index{
        case 0:
            return .compact
        case 1:
            return .full
        default:
            return .compact
        }
    }
}

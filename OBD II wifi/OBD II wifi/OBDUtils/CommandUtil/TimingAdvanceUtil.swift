//
//  TimingAdvanceUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class TimingAdvanceUtil {
    
    class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        if (stringArray.count < 3) {
            throw CommandError.indexError
        }
        let byteA = stringArray[2]
        
        let byteADecimal = UInt(strtoul(byteA, nil, 16))
        let calculation = (byteADecimal / 2) - 64
        return "\(calculation) ° relative to #1 cylinder"
    }
}

//
//  HybridBatteryPackRemaingLifeUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
open class HybridBatteryPackRemaingLifeUtil {
    
    open class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        
        let stringArray = result.components(separatedBy: " ")
        if (stringArray.count < 3) {
            throw CommandError.indexError
        }
        let firstByte = stringArray[2]
        
        guard let firstDecimal = UInt(firstByte, radix: 16), firstByte.count > 0 else {
            return "-"
        }
        
        let numerator: UInt = 100
        let denominator: UInt = 255
        let calculation = (numerator / denominator) * firstDecimal
        return "\(calculation) %"
    }
}

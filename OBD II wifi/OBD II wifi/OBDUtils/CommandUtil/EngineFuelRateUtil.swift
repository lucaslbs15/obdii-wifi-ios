//
//  EngineFuelRate.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class EngineFuelRateUtil {
    
    class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        let firstByte = stringArray[2]
        let secondByte = stringArray[3]
        
        guard let firstDecimal = UInt(firstByte, radix: 16), firstByte.count > 0 else {
            return "-"
        }
        guard let secondDecimal = UInt(secondByte, radix: 16), secondByte.count > 0 else {
            return "-"
        }
        
        let calculation = ((256 * firstDecimal) + secondDecimal) / 20
        return "\(calculation) L/h"
    }
}

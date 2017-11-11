//
//  FuelRailGaugePressureUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class FuelRailGaugePressureUtil {
    
    class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        if (stringArray.count < 4) {
            throw CommandError.indexError
        }
        let firstByte = stringArray[2]
        let secondByte = stringArray[3]
        
        guard let firstDecimal = UInt(firstByte, radix: 16), firstByte.count > 0 else {
            return "-"
        }
        
        guard let secondDecimal = UInt(secondByte, radix: 16), secondByte.count > 0 else {
            return "-"
        }
        let calculation = 10 * ((256 * firstDecimal) + secondDecimal)
        return "\(calculation) kPa"
    }
}

//
//  BarometricPressureUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class BarometricPressureUtil {
    
    class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        let byteA = stringArray[2]
        let byteADecimal = UInt(strtoul(byteA, nil, 16))
        return "\(byteADecimal) kPa"
    }
}

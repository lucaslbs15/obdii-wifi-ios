//
//  EngineOilTemperatureUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
open class EngineOilTemperatureUtil {
    
    open class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let subractNeeded: UInt8 = 40
        let stringArray: [String]! = result.components(separatedBy: " ")
        if (stringArray.count < 3) {
            throw CommandError.indexError
        }
        let desiredData = stringArray[2]
        if let value = UInt8(desiredData, radix: 16) {
            return "\(String(value - subractNeeded)) ºC"
        }
        return "-"
    }
}

//
//  MAFAirFlowRateUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 14/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class MAFAirFlowRateUtil {
    
    class func formatMAF(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        let byteADecimal = UInt(strtoul(stringArray[2], nil, 16))
        let byteBDecimal = UInt(strtoul(stringArray[3], nil, 16))
        let rateCalculated = ((256 * byteADecimal) + byteBDecimal) / 100
        return "\(rateCalculated) g/s"
    }
}

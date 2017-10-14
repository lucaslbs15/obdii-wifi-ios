//
//  MAFAirFlowRateUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 14/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class MAFAirFlowRateUtil {
    
    class func formatMAF(result: String) -> String {
        //result    String    "010D\r41 0D 00 \r\r>"
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        let byteAHex = stringArray[1]
        let byteBHex = stringArray[2]
        let byteADecimal = UInt(byteAHex, radix: 16)
        let byteBDecimal = UInt(byteBHex, radix: 16)
        let rateCalculated = ((256 * byteADecimal!) + byteBDecimal!) / 100
        return "\(rateCalculated) g/s"
    }
}

//
//  DistanceSinceCodesClearedUpUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 07/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class DistanceSinceCodesClearedUpUtil {
    class func formatDistance(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        let firstByte = UInt(strtoul(stringArray[2], nil, 16))
        let secondByte = UInt(strtoul(stringArray[3], nil, 16))
        let calculation = (firstByte * 256) + secondByte
        return "\(calculation) km"
    }
}

//
//  VehicleSpeed.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 14/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class VehicleSpeedUtil {
    
    class func formatSpeed(result: String) throws -> String {
        print("VehicleSpeedUtil - formatSpeed: \(result)")
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        if (stringArray.count < 3) {
            throw CommandError.indexError
        }
        let desiredData = stringArray[2]
        let speedInKmPerHour = UInt8(desiredData, radix: 16)
        return "\(speedInKmPerHour!) km/h"
    }
}

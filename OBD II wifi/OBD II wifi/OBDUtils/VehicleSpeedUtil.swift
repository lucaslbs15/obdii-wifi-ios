//
//  VehicleSpeed.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 14/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class VehicleSpeedUtil {
    
    class func formatSpeed(result: String) -> String {
        /*
         010D
         41 0D 00
         
         result    String    "010D\r41 0D 00 \r\r>"
         */
        print("VehicleSpeedUtil - formatSpeed: \(result)")
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        let desiredData = stringArray[2]
        let speedInKmPerHour = UInt8(desiredData, radix: 16)
        return "\(speedInKmPerHour!) km/h"
    }
}

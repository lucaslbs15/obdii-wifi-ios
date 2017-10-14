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
        let speedInKmPerHour = UInt8(result, radix: 16)
        return "\(String(describing: speedInKmPerHour)) km/h"
    }
}

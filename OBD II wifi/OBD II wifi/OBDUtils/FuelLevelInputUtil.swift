//
//  FuelLevelInputUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 14/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class FuelLevelInputUtil {
    
    class func formatLevel(result: String) -> String {
        print("Fuel level output: \(result)")
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        let desiredData = stringArray[2]
        let fuelLevel = UInt(strtoul(desiredData, nil, 16))
        if (fuelLevel < 128) {
            return "0 %"
        }
        let calculation = 0.7812 * Double((fuelLevel - 128))
        return "\(calculation) %"
    }
}

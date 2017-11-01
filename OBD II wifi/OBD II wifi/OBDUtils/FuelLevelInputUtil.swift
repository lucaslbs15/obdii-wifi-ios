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
        let fuelLevel = UInt8(desiredData, radix: 16)
        //0.7812 * (A - 128)
        //41 06 7E
        let calculation = Double((fuelLevel! - 128)) * 0.7812
        return "\(calculation) %"
    }
}

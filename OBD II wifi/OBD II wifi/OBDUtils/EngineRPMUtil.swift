//
//  EngineRPMUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 13/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class EngineRPMUtil {
    
    class func calculateRPM(result: String) -> String {
        let divideFor = 4
        
        let stringArray = result.components(separatedBy: " ")
        let firstByte = stringArray[2]
        let secondByte = stringArray[3]
        
        guard let firstDecimal = UInt8(firstByte, radix: 16), firstByte.count > 0 else {
            return "-"
        }
        
        guard let secondDecimal = UInt8(secondByte, radix: 16), secondByte.count > 0 else {
            return "-"
        }
        
        let desiredData: String = String(firstDecimal) + String(secondDecimal)
        let rpmValue = (Int(desiredData)! / divideFor)
        return String(rpmValue)
    }
}

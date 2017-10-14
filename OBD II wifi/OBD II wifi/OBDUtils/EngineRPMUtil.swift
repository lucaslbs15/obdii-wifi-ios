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
        print("EngineRPMUtil calculateRPM: \(result)")
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        
        let divideFor: UInt = 4
        let base: UInt = 256
        // formula ((A*256)+B)/4
        let stringArray = result.components(separatedBy: " ")
        let firstByte = stringArray[2]
        let secondByte = stringArray[3]
        
        guard let firstDecimal = UInt(firstByte, radix: 16), firstByte.count > 0 else {
            return "-"
        }
        
        guard let secondDecimal = UInt(secondByte, radix: 16), secondByte.count > 0 else {
            return "-"
        }
        
        /*

         let firstDecimal = UInt(firstByte, radix: 16)
         let secondDecimal = UInt(secondByte, radix: 16)
         //// formula ((A*256)+B)/4
         let resultRPM = ((firstDecimal! * 256) + seco
         */
        let rpmValue = ((firstDecimal * base) + secondDecimal) / divideFor
        return String(rpmValue)
    }
}

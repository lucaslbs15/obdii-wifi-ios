//
//  DeviceIdentifier.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class DeviceIdentifierUtil {
    
    class func formatCommand(identifier: String) throws -> String {
        if (identifier.characters.count != 12) {
            throw CommandError.wrongIdentifierSize(message: "\(identifier) must to be with 12 characters")
        }
        
        return "\(OBDCommandEnum.STORE_DEVICE_IDENTIFIER.rawValue) \(identifier)"
    }
    
    class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        
        let stringArray = result.components(separatedBy: "\r")
        if (stringArray.count < 2) {
            throw CommandError.indexError
        }
        return stringArray[1]
    }
}

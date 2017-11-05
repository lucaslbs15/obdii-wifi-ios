//
//  ResultUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 14/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class ResultUtil {
    
    class func hasNoData(result: String) -> Bool {
        return result.uppercased().range(of: ResultType.NO_DATA.rawValue) != nil
    }
    
    class func isUnableToConnect(result: String) -> Bool {
        return result.uppercased().range(of: ResultType.UNABLE_TO_CONNECT.rawValue) != nil
    }
    
    class func isReturnATCommand(result: String, obdCommand: OBDCommandEnum) -> Bool {
        return result.uppercased().range(of: obdCommand.rawValue) != nil
    }
    
    class func isReturn41Command(result: String, obdCommand: OBDCommandEnum) -> Bool {
        return result.uppercased().range(of: obdCommand.rawValue) != nil
    }
    
    class func rawResult(result: String) -> String {
        let stringReplaced = result.replacingOccurrences(of: "\r", with: " ").replacingOccurrences(of: ">", with: "")
        return stringReplaced
    }
}

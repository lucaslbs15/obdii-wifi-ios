//
//  FuelTypeUtil.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class FuelTypeUtil {
    
    class func formatResult(result: String) throws -> String {
        if (ResultUtil.hasNoData(result: result) || ResultUtil.isUnableToConnect(result: result)) {
            return "-"
        }
        let stringArray = result.components(separatedBy: " ")
        if (stringArray.count < 3) {
            throw CommandError.indexError
        }
        let valueType = UInt(stringArray[2], radix: 16)
        let fuelString = try valueFuelType(value: valueType!)
        return fuelString
    }
    
    class private func valueFuelType(value: UInt) throws -> String {
        let type:String
        switch value {
        case 0:
            type = FuelTypeEnum.NOT_AVAILABLE.rawValue
            break
        case 1:
            type = FuelTypeEnum.GASOLINE.rawValue
            break
        case 2:
            type = FuelTypeEnum.METHANOL.rawValue
            break
        case 3:
            type = FuelTypeEnum.ETHANOL.rawValue
            break
        case 4:
            type = FuelTypeEnum.DIESEL.rawValue
            break
        case 5:
            type = FuelTypeEnum.LPG.rawValue
            break
        case 6:
            type = FuelTypeEnum.CNG.rawValue
            break
        case 7:
            type = FuelTypeEnum.PROPANE.rawValue
            break
        case 8:
            type = FuelTypeEnum.ELECTRIC.rawValue
            break
        case 9:
            type = FuelTypeEnum.BIFUEL_RUNNING_GASOLINE.rawValue
            break
        case 10:
            type = FuelTypeEnum.BIFUEL_RUNNING_METHANOL.rawValue
            break
        case 11:
            type = FuelTypeEnum.BIFUEL_RUNNING_ETHANOL.rawValue
            break
        case 12:
            type = FuelTypeEnum.BIFUEL_RUNNING_LPG.rawValue
            break
        case 13:
            type = FuelTypeEnum.BIFUEL_RUNNING_CNG.rawValue
            break
        case 14:
            type = FuelTypeEnum.BIFUEL_RUNNING_PROPANE.rawValue
            break
        case 15:
            type = FuelTypeEnum.BIFUEL_RUNNING_ELECTRICITY.rawValue
            break
        case 16:
            type = FuelTypeEnum.BIFUEL_RUNNING_ELECTRIC_AND_COMBUSTION_ENGINE.rawValue
            break
        case 17:
            type = FuelTypeEnum.HYBRID_GASOLINE.rawValue
            break
        case 18:
            type = FuelTypeEnum.HYBRID_ETHANOL.rawValue
            break
        case 19:
            type = FuelTypeEnum.HYBRID_DIESEL.rawValue
            break
        case 20:
            type = FuelTypeEnum.HYBRID_ELECTRIC.rawValue
            break
        case 21:
            type = FuelTypeEnum.HYBRID_RUNNING_ELECTRIC_AND_COMBUSTION_ENGINE.rawValue
            break
        case 22:
            type = FuelTypeEnum.HYBRID_REGENERATIVE.rawValue
            break
        case 23:
            type = FuelTypeEnum.BIFUEL_RUNNING_DIESEL.rawValue
            break
        default:
            type = ResultType.UNREADABLE.rawValue
        }
        return type
    }
}

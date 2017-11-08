//
//  OBDUtils.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 07/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
import OBD2Connect
class OBDUtils {
    
    var connection: OBDConnection
    
    init(host: String, port: UInt32, completionQueue: DispatchQueue = DispatchQueue.main, timeout: TimeInterval = 0.100) {
        connection = OBDConnection(host: host, port: port, completionQueue: completionQueue, requestTimeout: timeout)
    }
    
    func printLogWhenStateChange() {
        connection.onStateChanged = { state in
            print(state)
        }
    }
    
    func openConnection() {
        connection.open()
    }
    
    func closeConnection() {
        connection.close()
    }
    
    func startRead(deadline: Int, dataString: String) {
        let commandString: String = "\(dataString)\r"
        let dataToSend: Data = commandString.data(using: .ascii)!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(deadline), qos: .default, flags: .assignCurrentContext, execute: {
            self.connection.send(data: dataToSend, completion: { data in
                data.onSuccess(block: {                    
                    data in print(data)
                })
                
                data.onFailure(block: {
                    error in print(String(describing: error))
                })
                })
            })
    }
    
    func startRead(deadline: Int, dataString: String, completion: @escaping (_ result: String) -> Void) {
        let commandString: String = "\(dataString)\r"
        let dataToSend: Data = commandString.data(using: .ascii)!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(deadline), qos: .default, flags: .assignCurrentContext, execute: {
            self.connection.send(data: dataToSend, completion: { data in
                data.onSuccess(block: {
                    data in
                    print("send onSuccess: \(data)")
                    completion(data)
                })
                
                data.onFailure(block: {
                    error in completion(String(describing: error))
                })
            })
        })
    }
    
    func startRead(deadline: Int, dataString: String, label: UILabel!, completion: @escaping (_ result: String) -> Void) {
        let commandString: String = "\(dataString)\r"
        let dataToSend: Data = commandString.data(using: .ascii)!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(deadline), qos: .default, flags: .assignCurrentContext, execute: {
            self.connection.send(data: dataToSend, completion: { data in
                data.onSuccess(block: {
                    data in
                    print("send onSuccess: \(data)")
                    label.text = ResultUtil.rawResult(result: data)
                    completion(data)
                })
                
                data.onFailure(block: {
                    error in completion(String(describing: error))
                })
            })
        })
    }
    
    func prepareToRead(obdCommand: OBDCommandEnum, completion: @escaping (_ result: Bool) -> Void) {
        startRead(deadline: 4, dataString: obdCommand.rawValue) {
            (result: String) in
            print("prepareToRead: \(result)")
            completion(true)
        }
    }
    
    class func replaceOBDCommandResult(result: String, obdCommand: OBDCommandEnum) -> String! {
        var resultFormatted: String!
        switch obdCommand {
        case .IDENTITY, .PROTOCOL_0, .DISPLAY_ACTIVITY_MONITOR_COUNT,
             .MONITOR_ALL, .READ_INPUT_VOLTAGE, .RESET:
            do {
                resultFormatted = try replaceATCommand(result: result, obdCommand: obdCommand)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .ENGINE_COOLANT_TEMPERATURE:
            do {
                resultFormatted = try EngineCoolantTemperatureUtil.calculeTemperature(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .ENGINE_RPM:
            do {
                resultFormatted = try EngineRPMUtil.calculateRPM(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .INTAKE_AIR_TEMPERATURE:
            do {
                resultFormatted = try IntakeAirTemperatureUtil.calculeTemperature(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .VEHICLE_SPEED:
            do {
                resultFormatted = try VehicleSpeedUtil.formatSpeed(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .FUEL_LEVEL_INPUT:
            do {
                resultFormatted = try FuelLevelInputUtil.formatLevel(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .FUEL_PRESSURE:
            do {
                resultFormatted = try FuelPressureUtil.formatPressure(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .RUN_TIME_SINCE_ENGINE_START:
            do {
                resultFormatted = try RunTimeSinceEngineStartUtil.formatRunTime(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .AMBIENT_AIR_TEMPERATURE:
            do {
                resultFormatted = try AmbientAirTemperatureUtil.calculeTemperature(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .MAF_AIR_FLOW_RATE:
            do {
                resultFormatted = try MAFAirFlowRateUtil.formatMAF(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        case .DISTANCE_TRAVELED_SINCE_CODES_CLEARED_UP:
            do {
                resultFormatted = try DistanceSinceCodesClearedUpUtil.formatDistance(result: result)
            } catch {
                resultFormatted = ResultType.UNREADABLE.rawValue
            }
            break
        default:
            resultFormatted = result
        }
        return resultFormatted
    }
    
    class func replaceATCommand(result: String, obdCommand: OBDCommandEnum) throws -> String! {
        if (!ResultUtil.isReturnATCommand(result: result, obdCommand: obdCommand)) {
            return nil
        }
        let resultArray = result.components(separatedBy: "\(obdCommand.rawValue)\r")
        return resultArray[1]
    }
    
    class func replace41Command(result: String, obdCommand: OBDCommandEnum) throws -> String! {
        if (!ResultUtil.isReturn41Command(result: result, obdCommand: obdCommand)) {
            return nil
        }
        let resultArray = result.components(separatedBy: "\(obdCommand.rawValue)\r")
        return resultArray[1]
    }
}

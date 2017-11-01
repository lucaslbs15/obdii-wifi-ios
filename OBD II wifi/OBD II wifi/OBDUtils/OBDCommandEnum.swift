//
//  OBDCommandEnum.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 12/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
enum OBDCommandEnum: String {
    case NONE = "NONE"
    case RESET = "ATZ"
    case IDENTITY = "ATI"
    case READ_INPUT_VOLTAGE = "ATRV"
    case FUEL_LEVEL_INPUT = "0106"
    case FUEL_PRESSURE = "010A"
    case FUEL_PRESSURE_DIESEL = "0123"
    case ENGINE_COOLANT_TEMPERATURE = "0105"
    case ENGINE_RPM = "010C"
    case VEHICLE_SPEED = "010D"
    case RUN_TIME_SINCE_ENGINE_START = "011F"
    case AMBIENT_AIR_TEMPERATURE = "0146"
    case MONITOR_ALL = "ATMA"
    case DISPLAY_ACTIVITY_MONITOR_COUNT = "ATAMC"
    case PROTOCOL_0 = "ATSP0"
    case PROVE_WORKING = "0100"
    case INTAKE_AIR_TEMPERATURE = "010F"
    case MAF_AIR_FLOW_RATE = "0110"
}

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
    case FUEL_LEVEL_INPUT = "0106"//util
    case FUEL_PRESSURE = "010A"//util
    case ENGINE_COOLANT_TEMPERATURE = "0105"//util
    case ENGINE_RPM = "010C"//util
    case VEHICLE_SPEED = "010D"//util
    case RUN_TIME_SINCE_ENGINE_START = "011F"//util
    case AMBIENT_AIR_TEMPERATURE = "0146"//util
    case MONITOR_ALL = "ATMA"
    case DISPLAY_ACTIVITY_MONITOR_COUNT = "ATAMC"
    case PROTOCOL_0 = "ATSP0"
    case PROVE_WORKING = "0100"
    case INTAKE_AIR_TEMPERATURE = "010F"//util
    case MAF_AIR_FLOW_RATE = "0110"//util
    case TIMING_ADVANCE = "010E"//util
    case INTAKE_MANIFOLD_PRESSURE = "010B"//util
    case BAROMETRIC_PRESSURE = "0133"//util
    case DISTANCE_TRAVELED_WITH_MALFUNCTION = "0121"//util
    case FUEL_RAIL_PRESSURE = "0122"//util
    case FUEL_RAIL_GAUGE_PRESSURE = "0123"//util
    case FUEL_TYPE = "0151"//util
    case FUEL_PRESSURE_CONTROL_SYSTEM = "016D"
    case INJECTION_PRESSURE_CONTROL_SYSTEM = "016E"
    case ENGINE_OIL_TEMPERATURE = "015C"//util
    case FUEL_INJECTION_TIMING = "015D"//util
    case ENGINE_FUEL_RATE = "015E"//util
    case HYBRID_BATTERY_PACK_REMAINING_LIFE = "015B"//util
    case DISTANCE_TRAVELED_SINCE_CODES_CLEARED_UP = "0131"//util
    case DISPLAY_DEVICE_IDENTIFIER = "AT@2"//util
    case STORE_DEVICE_IDENTIFIER = "AT@3"//util
}

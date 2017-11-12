//
//  FuelType.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
enum FuelTypeEnum: String {
    case NOT_AVAILABLE = "Not available"
    case GASOLINE = "Gasoline"
    case METHANOL = "Methanol"
    case ETHANOL = "Ethanol"
    case DIESEL = "Diesel"
    case LPG = "LPG"
    case CNG = "CNG"
    case PROPANE = "Propane"
    case ELECTRIC = "Electric"
    case BIFUEL_RUNNING_GASOLINE = "Bifuel running Gasoline"
    case BIFUEL_RUNNING_METHANOL = "Bifuel running Methanol"
    case BIFUEL_RUNNING_ETHANOL = "Bifuel running Ethanol"
    case BIFUEL_RUNNING_LPG = "Bifuel running LPG"
    case BIFUEL_RUNNING_CNG = "Bifuel running CNG"
    case BIFUEL_RUNNING_PROPANE = "Bifuel running Propane"
    case BIFUEL_RUNNING_ELECTRICITY = "Bifuel running Electricity"
    case BIFUEL_RUNNING_ELECTRIC_AND_COMBUSTION_ENGINE = "Bifuel running electric and combustion engine"
    case HYBRID_GASOLINE = "Hybrid Gasoline"
    case HYBRID_ETHANOL = "Hybrid Ethanol"
    case HYBRID_DIESEL = "Hybrid Diesel"
    case HYBRID_ELECTRIC = "Hybrid Electric"
    case HYBRID_RUNNING_ELECTRIC_AND_COMBUSTION_ENGINE = "Hybrid running electric and combustion engine"
    case HYBRID_REGENERATIVE = "Hybrid Regenerative"
    case BIFUEL_RUNNING_DIESEL = "Bifuel running Diesel"
}

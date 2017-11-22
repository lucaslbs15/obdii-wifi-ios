//
//  CommandError.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 11/11/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
public enum CommandError: Error {
    case wrongIdentifierSize(message: String)
    case unableToConnect
    case indexError
}

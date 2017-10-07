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
    
    init(host: String, port: UInt32, completionQueue: DispatchQueue, timeout: TimeInterval) {
        connection = OBDConnection(host: host, port: port, completionQueue: completionQueue, requestTimeout: timeout)
    }
    
    func openConnection() {
        connection.open()
    }
    
    func closeConnection() {
        connection.close()
    }
    
    func startRead(deadline: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(deadline), qos: .default, flags: .assignCurrentContext, execute: {
            self.connection.send(data: "ATZ\r".data(using: .ascii)!, completion: { data in
                data.onSuccess(block: {
                    data in print(data)
                })
                
                data.onFailure(block: {
                    error in print(String(describing: error))
                })
                })
            })
    }
}

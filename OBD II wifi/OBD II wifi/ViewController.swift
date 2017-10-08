//
//  ViewController.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 07/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var obdUtils: OBDUtils!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ATZ\r
        obdUtils = OBDUtils(host: "192.168.0.10", port: 35000)
        obdUtils.printLogWhenStateChange()
        obdUtils.openConnection()
    }
    
    @IBAction func sendData() {
        print("sendData()")
        obdUtils.startRead(deadline: 4, dataToSend: "ATZ\r")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


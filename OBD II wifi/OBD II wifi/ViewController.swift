//
//  ViewController.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 07/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputCommand: UITextField!;
    private let defaultCommand: String = "BAZINGA!"
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
        // ATI = Identify yourself; ATRV = Read the input Voltage; 012F = Fuel Level Input; 0123 = Fuel Pressure (diesel);
        // 0105 = Engine Coolant Temperature; 010A = Fuel Pressure; 010C = Engine RPM; 010D = Vehicle speed;
        // 011F = Run time since engine start; 0146 = Ambient air temperature; ATMA = Monitor All; ATAMC = display Activity Monitor Count;
        
        obdUtils.startRead(deadline: 4, dataString: inputCommand.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


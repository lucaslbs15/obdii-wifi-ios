//
//  ViewController.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 07/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    private var obdUtils: OBDUtils!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendData() {
        configOBDConnection()
        obdUtils.startRead(deadline: 4, dataString: OBDCommandEnum.READ_INPUT_VOLTAGE.rawValue)
    }
    
    private func configOBDConnection() {
        obdUtils = OBDUtils(host: hostTextField.text!, port: UInt32(portTextField.text!)!)
        obdUtils.printLogWhenStateChange()
        obdUtils.openConnection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


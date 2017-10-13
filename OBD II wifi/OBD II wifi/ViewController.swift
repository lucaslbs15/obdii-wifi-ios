//
//  ViewController.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 07/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sendDataButton: UIButton!
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var identityLabel: UILabel!;
    @IBOutlet weak var voltageLabel: UILabel!;
    @IBOutlet weak var fuelInputLabel: UILabel!;
    @IBOutlet weak var fuelPressureLabel: UILabel!;
    @IBOutlet weak var engineTemperatureLabel: UILabel!;
    @IBOutlet weak var engineRPMLabel: UILabel!;
    @IBOutlet weak var vehicleSpeedLabel: UILabel!;
    @IBOutlet weak var runTimeEngineLabel: UILabel!;
    @IBOutlet weak var ambientTemperatureLabel: UILabel!;
    
    private var obdUtils: OBDUtils!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendData() {
        sendDataButton.titleLabel?.text = "Reconectar"
        configOBDConnection()
        prepareToRead(obdCommand: OBDCommandEnum.RESET)
    }
    
    private func configOBDConnection() {
        obdUtils = OBDUtils(host: hostTextField.text!, port: UInt32(portTextField.text!)!)
        obdUtils.printLogWhenStateChange()
        obdUtils.openConnection()
    }
    
    private func prepareToRead(obdCommand: OBDCommandEnum) {
        obdUtils.prepareToRead(obdCommand: obdCommand) {
            (result: Bool) in
            self.choosePrepareToRead(previousOBDCommand: obdCommand)
        }
    }
    
    private func choosePrepareToRead(previousOBDCommand: OBDCommandEnum) {
        switch previousOBDCommand {
        case .RESET:
            prepareToRead(obdCommand: OBDCommandEnum.PROTOCOL_0)
            break
        case .PROTOCOL_0:
            readInfos()
            break
        default:
            readInfos()
        }
    }
    
    private func readInfos() {
        chooseDataToSend(previousOBDCommand: OBDCommandEnum.NONE)
    }
    
    private func sendData(obdCommand: OBDCommandEnum, label: UILabel) {
        obdUtils.startRead(deadline: 4, dataString: obdCommand.rawValue) {
            (result: String) in
            label.text = OBDUtils.replaceOBDCommandResult(result: result, obdCommand: obdCommand)
            self.chooseDataToSend(previousOBDCommand: obdCommand)
        }
    }
    
    private func chooseDataToSend(previousOBDCommand: OBDCommandEnum) {
        switch previousOBDCommand {
        case .IDENTITY:
            sendData(obdCommand: OBDCommandEnum.READ_INPUT_VOLTAGE, label: voltageLabel)
            break
        case .READ_INPUT_VOLTAGE:
            sendData(obdCommand: OBDCommandEnum.FUEL_LEVEL_INPUT, label: fuelInputLabel)
            break
        case .FUEL_LEVEL_INPUT:
            sendData(obdCommand: OBDCommandEnum.FUEL_PRESSURE, label: fuelPressureLabel)
            break
        case .FUEL_PRESSURE:
            sendData(obdCommand: OBDCommandEnum.ENGINE_COOLANT_TEMPERATURE, label: engineTemperatureLabel)
            break
        case .ENGINE_COOLANT_TEMPERATURE:
            sendData(obdCommand: OBDCommandEnum.ENGINE_RPM, label: engineRPMLabel)
            break
        case .ENGINE_RPM:
            sendData(obdCommand: OBDCommandEnum.VEHICLE_SPEED, label: vehicleSpeedLabel)
            break
        case .VEHICLE_SPEED:
            sendData(obdCommand: OBDCommandEnum.RUN_TIME_SINCE_ENGINE_START, label: runTimeEngineLabel)
            break
        case .RUN_TIME_SINCE_ENGINE_START:
            sendData(obdCommand: OBDCommandEnum.AMBIENT_AIR_TEMPERATURE, label: ambientTemperatureLabel)
            break
        default:
            sendData(obdCommand: OBDCommandEnum.IDENTITY, label: identityLabel)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


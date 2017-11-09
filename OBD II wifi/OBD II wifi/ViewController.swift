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
    @IBOutlet weak var identityHexLabel: UILabel!;
    @IBOutlet weak var voltageLabel: UILabel!;
    @IBOutlet weak var voltageHexLabel: UILabel!;
    @IBOutlet weak var fuelInputLabel: UILabel!;
    @IBOutlet weak var fuelInputHexLabel: UILabel!;
    @IBOutlet weak var fuelPressureLabel: UILabel!;
    @IBOutlet weak var fuelPressureHexLabel: UILabel!;
    @IBOutlet weak var engineTemperatureLabel: UILabel!;
    @IBOutlet weak var engineTemperatureHexLabel: UILabel!;
    @IBOutlet weak var engineRPMLabel: UILabel!;
    @IBOutlet weak var engineRPMHexLabel: UILabel!;
    @IBOutlet weak var vehicleSpeedLabel: UILabel!;
    @IBOutlet weak var vehicleSpeedHexLabel: UILabel!;
    @IBOutlet weak var runTimeEngineLabel: UILabel!;
    @IBOutlet weak var runTimeEngineHexLabel: UILabel!;
    @IBOutlet weak var ambientTemperatureLabel: UILabel!;
    @IBOutlet weak var ambientTemperatureHexLabel: UILabel!;
    @IBOutlet weak var mafAirFlowRateLabel: UILabel!;
    @IBOutlet weak var mafAirFlowRateHexLabel: UILabel!;
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusHexLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var activityMonitorCountLabel: UILabel!
    @IBOutlet weak var activityMonitorCountHexLabel: UILabel!
    @IBOutlet weak var intakeAirTempLabel: UILabel!
    @IBOutlet weak var intakeAirTempHexLabel: UILabel!
    @IBOutlet weak var intakeManifoldPressureLabel: UILabel!
    @IBOutlet weak var intakeManifoldPressureHexLabel: UILabel!
    @IBOutlet weak var timingAdvanceLabel: UILabel!
    @IBOutlet weak var timingAdvanceHexLabel: UILabel!
    @IBOutlet weak var fuelPressureDieselLabel: UILabel!
    @IBOutlet weak var fuelPressureDieselHexLabel: UILabel!
    @IBOutlet weak var barometricPressureLabel: UILabel!
    @IBOutlet weak var barometricPressureHexLabel: UILabel!
    @IBOutlet weak var distanceTraveledWithMalfunctionLabel: UILabel!
    @IBOutlet weak var distanceTraveledWithMalfunctionHexLabel: UILabel!
    @IBOutlet weak var fuelRailPressureLabel: UILabel!
    @IBOutlet weak var fuelRailPressureHexLabel: UILabel!
    @IBOutlet weak var fuelRailGaugePressureLabel: UILabel!
    @IBOutlet weak var fuelRailGaugePressureHexLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var fuelTypeHexLabel: UILabel!
    @IBOutlet weak var fuelPressureControlSystemLabel: UILabel!
    @IBOutlet weak var fuelPressureControlSystemHexLabel: UILabel!
    @IBOutlet weak var injectionPressureControlSystemLabel: UILabel!
    @IBOutlet weak var injectionPressureControlSystemHexLabel: UILabel!
    @IBOutlet weak var engineOilTemperaturaLabel: UILabel!
    @IBOutlet weak var engineOilTemperaturaHexLabel: UILabel!
    @IBOutlet weak var fuelInjectionTimingLabel: UILabel!
    @IBOutlet weak var fuelInjectionTimingHexLabel: UILabel!
    @IBOutlet weak var engineFuelRateLabel: UILabel!
    @IBOutlet weak var engineFuelRateHexLabel: UILabel!
    @IBOutlet weak var hybridBatteryPackRemainingLifeLabel: UILabel!
    @IBOutlet weak var hybridBatteryPackRemainingLifeHexLabel: UILabel!
    @IBOutlet weak var distanceTraveledSinceCodeClearedUpLabel: UILabel!
    @IBOutlet weak var distanceTraveledSinceCodeClearedUpHexLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var storeIdentifierButton: UIButton!
    
    var previousLabel: UILabel!
    var defaultFont: UIFont!
    
    private var obdUtils: OBDUtils!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        defaultFont = identityLabel.font
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        storeIdentifierButton.isEnabled = true
    }
    
    @IBAction func sendData() {
        sendDataButton.isEnabled = false
        statusLabel.text = "Conectando..."
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
            print("commad prepared: \(obdCommand.rawValue)")
            self.choosePrepareToRead(previousOBDCommand: obdCommand)
        }
    }
    
    private func choosePrepareToRead(previousOBDCommand: OBDCommandEnum) {
        switch previousOBDCommand {
        case .RESET:
            prepareToRead(obdCommand: OBDCommandEnum.PROTOCOL_0)
            break
        case .PROTOCOL_0:
            prepareToRead(obdCommand: OBDCommandEnum.PROVE_WORKING)
            break
        default:
            readInfos()
        }
    }
    
    private func readInfos() {
        statusLabel.text = "Buscando dados..."
        chooseDataToSend(previousOBDCommand: OBDCommandEnum.NONE)
    }
    
    private func sendData(obdCommand: OBDCommandEnum, label: UILabel) {
        obdUtils.startRead(deadline: 1, dataString: obdCommand.rawValue) {
            (result: String) in
            if let commandResult = OBDUtils.replaceOBDCommandResult(result: result, obdCommand: obdCommand) {
                self.setLabel(label: label, commandResult: commandResult, obdCommand: obdCommand)
            } else {
                self.showErrorAlert()
            }
        }
    }
    
    private func sendData(obdCommand: OBDCommandEnum, label: UILabel, labelWithHex: UILabel) {
        obdUtils.startRead(deadline: 1, dataString: obdCommand.rawValue, label: labelWithHex) {
            (result: String) in
            if let commandResult = OBDUtils.replaceOBDCommandResult(result: result, obdCommand: obdCommand) {
                self.setLabel(label: label, commandResult: commandResult, obdCommand: obdCommand)
            } else {
                self.showErrorAlert()
            }
        }
    }
    
    private func setLabel(label: UILabel, commandResult: String, obdCommand: OBDCommandEnum) {
        label.text = commandResult
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        if (self.previousLabel != nil) {
            self.previousLabel.font = self.defaultFont
        }
        self.previousLabel = label
        self.chooseDataToSend(previousOBDCommand: obdCommand)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Atenção", message: "Não foi possível conectar no dispositivo OBD II. Verifique se o seu iOS está conectado via wifi com o OBD II do carro. Feche e abra novamente o aplicativo.", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func chooseDataToSend(previousOBDCommand: OBDCommandEnum) {
        switch previousOBDCommand {
        case .IDENTITY:
            sendData(obdCommand: OBDCommandEnum.DISPLAY_DEVICE_IDENTIFIER, label: voltageLabel)
            break
        case .DISPLAY_DEVICE_IDENTIFIER:
            sendData(obdCommand: OBDCommandEnum.READ_INPUT_VOLTAGE, label: voltageLabel, labelWithHex: voltageHexLabel)
            break
        case .READ_INPUT_VOLTAGE:
            sendData(obdCommand: OBDCommandEnum.FUEL_LEVEL_INPUT, label: fuelInputLabel, labelWithHex: fuelInputHexLabel)
            break
        case .FUEL_LEVEL_INPUT:
            sendData(obdCommand: OBDCommandEnum.FUEL_PRESSURE, label: fuelPressureLabel, labelWithHex: fuelPressureHexLabel)
            break
        case .FUEL_PRESSURE:
            sendData(obdCommand: OBDCommandEnum.ENGINE_COOLANT_TEMPERATURE, label: engineTemperatureLabel, labelWithHex: engineTemperatureHexLabel)
            break
        case .ENGINE_COOLANT_TEMPERATURE:
            sendData(obdCommand: OBDCommandEnum.ENGINE_RPM, label: engineRPMLabel, labelWithHex: engineRPMHexLabel)
            break
        case .ENGINE_RPM:
            sendData(obdCommand: OBDCommandEnum.VEHICLE_SPEED, label: vehicleSpeedLabel, labelWithHex: vehicleSpeedHexLabel)
            break
        case .VEHICLE_SPEED:
            sendData(obdCommand: OBDCommandEnum.RUN_TIME_SINCE_ENGINE_START, label: runTimeEngineLabel, labelWithHex: runTimeEngineHexLabel)
            break
        case .RUN_TIME_SINCE_ENGINE_START:
            sendData(obdCommand: OBDCommandEnum.AMBIENT_AIR_TEMPERATURE, label: ambientTemperatureLabel, labelWithHex: ambientTemperatureHexLabel)
            break
        case .AMBIENT_AIR_TEMPERATURE:
            sendData(obdCommand: OBDCommandEnum.MAF_AIR_FLOW_RATE, label: mafAirFlowRateLabel, labelWithHex: mafAirFlowRateHexLabel)
            break
        case .MAF_AIR_FLOW_RATE:
            sendData(obdCommand: OBDCommandEnum.DISPLAY_ACTIVITY_MONITOR_COUNT, label: activityMonitorCountLabel, labelWithHex: activityMonitorCountHexLabel)
            break
        case .DISPLAY_ACTIVITY_MONITOR_COUNT:
            sendData(obdCommand: OBDCommandEnum.INTAKE_AIR_TEMPERATURE, label: intakeAirTempLabel, labelWithHex: intakeAirTempHexLabel)
            break
        case .INTAKE_AIR_TEMPERATURE:
            sendData(obdCommand: OBDCommandEnum.INTAKE_MANIFOLD_PRESSURE, label: intakeManifoldPressureLabel, labelWithHex: intakeManifoldPressureHexLabel)
            break
        case .INTAKE_MANIFOLD_PRESSURE:
            sendData(obdCommand: OBDCommandEnum.TIMING_ADVANCE, label: timingAdvanceLabel, labelWithHex: timingAdvanceHexLabel)
            break
        case .TIMING_ADVANCE:
            sendData(obdCommand: OBDCommandEnum.BAROMETRIC_PRESSURE, label: barometricPressureLabel, labelWithHex: barometricPressureHexLabel)
            break
        case .BAROMETRIC_PRESSURE:
            sendData(obdCommand: OBDCommandEnum.DISTANCE_TRAVELED_WITH_MALFUNCTION, label: distanceTraveledWithMalfunctionLabel, labelWithHex: distanceTraveledWithMalfunctionHexLabel)
            break
        case .DISTANCE_TRAVELED_WITH_MALFUNCTION:
            sendData(obdCommand: OBDCommandEnum.FUEL_RAIL_PRESSURE, label: fuelRailPressureLabel, labelWithHex: fuelRailPressureHexLabel)
            break
        case .FUEL_RAIL_PRESSURE:
            sendData(obdCommand: OBDCommandEnum.FUEL_RAIL_GAUGE_PRESSURE, label: fuelRailGaugePressureLabel, labelWithHex: fuelRailGaugePressureHexLabel)
            break
        case .FUEL_RAIL_GAUGE_PRESSURE:
            sendData(obdCommand: OBDCommandEnum.FUEL_TYPE, label: fuelTypeLabel, labelWithHex: fuelTypeHexLabel)
            break
        case .FUEL_TYPE:
            sendData(obdCommand: OBDCommandEnum.FUEL_PRESSURE_CONTROL_SYSTEM, label: fuelPressureControlSystemLabel, labelWithHex: fuelPressureControlSystemHexLabel)
            break
        case .FUEL_PRESSURE_CONTROL_SYSTEM:
            sendData(obdCommand: OBDCommandEnum.INJECTION_PRESSURE_CONTROL_SYSTEM, label: injectionPressureControlSystemLabel, labelWithHex: injectionPressureControlSystemHexLabel)
            break
        case .INJECTION_PRESSURE_CONTROL_SYSTEM:
            sendData(obdCommand: OBDCommandEnum.ENGINE_OIL_TEMPERATURE, label: engineOilTemperaturaLabel, labelWithHex: engineOilTemperaturaHexLabel)
            break
        case .ENGINE_OIL_TEMPERATURE:
            sendData(obdCommand: OBDCommandEnum.FUEL_INJECTION_TIMING, label: fuelInjectionTimingLabel, labelWithHex: fuelInjectionTimingHexLabel)
            break
        case .FUEL_INJECTION_TIMING:
            sendData(obdCommand: OBDCommandEnum.HYBRID_BATTERY_PACK_REMAINING_LIFE, label: hybridBatteryPackRemainingLifeLabel, labelWithHex: hybridBatteryPackRemainingLifeHexLabel)
            break
        case .HYBRID_BATTERY_PACK_REMAINING_LIFE:
            sendData(obdCommand: OBDCommandEnum.ENGINE_FUEL_RATE, label: engineFuelRateLabel, labelWithHex: engineFuelRateHexLabel)
            break
        case .ENGINE_FUEL_RATE:
            sendData(obdCommand: OBDCommandEnum.DISTANCE_TRAVELED_SINCE_CODES_CLEARED_UP, label: distanceTraveledSinceCodeClearedUpLabel, labelWithHex: distanceTraveledSinceCodeClearedUpHexLabel)
            break
        case .DISTANCE_TRAVELED_SINCE_CODES_CLEARED_UP:
            prepareToRead(obdCommand: OBDCommandEnum.RESET)
            break
        default:
            sendData(obdCommand: OBDCommandEnum.IDENTITY, label: identityLabel, labelWithHex: identityHexLabel)
        }
    }
    
    @IBAction func storeIdentifierAction() {
        storeDeviceIdentifier()
    }
    
    private func storeDeviceIdentifier() {
        let defaultIdentifier = "000000000001"
        let commandToSend = "\(OBDCommandEnum.STORE_DEVICE_IDENTIFIER.rawValue) \(identifierTextField.text ?? defaultIdentifier)"
        print("commandToSend: \(commandToSend)")
        
        /*obdUtils.startRead(deadline: 1, dataString: commandToSend) {
            (result: String) in
            print("storeDeviceIdentifier() - result: \(result)")
            self.chooseDataToSend(previousOBDCommand: OBDCommandEnum.STORE_DEVICE_IDENTIFIER)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func tap(gesture: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}


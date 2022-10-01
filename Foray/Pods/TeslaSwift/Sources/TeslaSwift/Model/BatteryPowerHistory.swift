//
//  BatteryPowerHistory.swift
//  TeslaSwift
//
//  Created by Alec on 11/24/21.
//  Copyright © 2021 Joao Nunes. All rights reserved.
//

import Foundation

// MARK: - BatteryPowerHistory
open class BatteryPowerHistory: Codable {
    open var serialNumber: String
    open var timeSeries: [TimeSeries]
    open var selfConsumptionData: [SelfConsumptionDatum]

    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case timeSeries = "time_series"
        case selfConsumptionData = "self_consumption_data"
    }
    
    
    // MARK: - SelfConsumptionDatum
    open class SelfConsumptionDatum: Codable {
        open var timestamp: Date
        open var solar: Double
        open var battery: Double
    }

    // MARK: - TimeSeries
    open class TimeSeries: Codable {
        open var timestamp: Date
        open var solarPower:Double
        open var batteryPower:Double
        open var gridPower: Double
        open var gridServicesPower:Double
        open var generatorPower: Double

        enum CodingKeys: String, CodingKey {
            case timestamp
            case solarPower = "solar_power"
            case batteryPower = "battery_power"
            case gridPower = "grid_power"
            case gridServicesPower = "grid_services_power"
            case generatorPower = "generator_power"
        }
    }
}

//
//  EnergySiteHistory.swift
//  TeslaSwift
//
//  Created by Alec on 11/24/21.
//  Copyright © 2021 Joao Nunes. All rights reserved.
//

import Foundation

// MARK: - EnergySiteHistory
open class EnergySiteHistory: Codable {
    open var serialNumber: String
    open var period: Period
    open var timeSeries: [TimeSeries]

    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case period
        case timeSeries = "time_series"
    }
    
    public enum Period: String, Codable {
        case day, week, month, year
    }
    
    // MARK: - TimeSeries
    open class TimeSeries: Codable {
        open var timestamp: Date
        open var solarEnergyExported: Double
        open var generatorEnergyExported: Double
        open var gridEnergyImported: Double
        open var gridServicesEnergyImported: Double
        open var gridServicesEnergyExported: Double
        open var gridEnergyExportedFromSolar: Double
        open var gridEnergyExportedFromGenerator: Double
        open var gridEnergyExportedFromBattery: Double
        open var batteryEnergyExported: Double
        open var batteryEnergyImportedFromGrid: Double
        open var batteryEnergyImportedFromSolar: Double
        open var batteryEnergyImportedFromGenerator: Double
        open var consumerEnergyImportedFromGrid: Double
        open var consumerEnergyImportedFromSolar: Double
        open var consumerEnergyImportedFromBattery: Double
        open var consumerEnergyImportedFromGenerator: Double

        enum CodingKeys: String, CodingKey {
            case timestamp
            case solarEnergyExported = "solar_energy_exported"
            case generatorEnergyExported = "generator_energy_exported"
            case gridEnergyImported = "grid_energy_imported"
            case gridServicesEnergyImported = "grid_services_energy_imported"
            case gridServicesEnergyExported = "grid_services_energy_exported"
            case gridEnergyExportedFromSolar = "grid_energy_exported_from_solar"
            case gridEnergyExportedFromGenerator = "grid_energy_exported_from_generator"
            case gridEnergyExportedFromBattery = "grid_energy_exported_from_battery"
            case batteryEnergyExported = "battery_energy_exported"
            case batteryEnergyImportedFromGrid = "battery_energy_imported_from_grid"
            case batteryEnergyImportedFromSolar = "battery_energy_imported_from_solar"
            case batteryEnergyImportedFromGenerator = "battery_energy_imported_from_generator"
            case consumerEnergyImportedFromGrid = "consumer_energy_imported_from_grid"
            case consumerEnergyImportedFromSolar = "consumer_energy_imported_from_solar"
            case consumerEnergyImportedFromBattery = "consumer_energy_imported_from_battery"
            case consumerEnergyImportedFromGenerator = "consumer_energy_imported_from_generator"
        }
    }
}

//
//  EnergySiteStatus.swift
//  TeslaSwift
//
//  Created by Alec on 11/24/21.
//  Copyright © 2021 Joao Nunes. All rights reserved.
//

import Foundation

// MARK: - EnergySiteStatus
open class EnergySiteStatus: Codable {
    open var resourceType: String
    open var siteName: String
    open var gatewayID: String
    open var energyLeft: Double
    open var totalPackEnergy: Double
    open var percentageCharged: Double
    open var batteryType: String
    open var backupCapable: Bool
    open var batteryPower: Double
    open var syncGridAlertEnabled: Bool
    open var breakerAlertEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case resourceType = "resource_type"
        case siteName = "site_name"
        case gatewayID = "gateway_id"
        case energyLeft = "energy_left"
        case totalPackEnergy = "total_pack_energy"
        case percentageCharged = "percentage_charged"
        case batteryType = "battery_type"
        case backupCapable = "backup_capable"
        case batteryPower = "battery_power"
        case syncGridAlertEnabled = "sync_grid_alert_enabled"
        case breakerAlertEnabled = "breaker_alert_enabled"
    }
}

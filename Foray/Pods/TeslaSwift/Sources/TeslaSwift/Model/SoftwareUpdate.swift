//
//  SoftwareUpdate.swift
//  TeslaSwift
//
//  Created by Derek Johnson on 10/31/18.
//  Copyright © 2018 Derek Johnson. All rights reserved.
//

import Foundation

open class SoftwareUpdate: Codable {
	
    open var status: String?
    open var expectedDuration: Int?
    open var scheduledTime: Double?
    open var warningTimeRemaining: Double?
    open var downloadPercentage: Int?
    open var installPercentage: Int?
    open var version: String?
    
    enum CodingKeys: String, CodingKey {
        case status                  = "status"
        case expectedDuration        = "expected_duration_sec"
        case scheduledTime           = "scheduled_time_ms"
        case warningTimeRemaining    = "warning_time_remaining_ms"
        case downloadPercentage = "download_perc"
        case installPercentage = "install_perc"
        case version = "version"
    }
}

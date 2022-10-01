//
//  ScheduledDepartureCommandOptions.swift
//  TeslaSwift
//
//  Created by Philip Engberg on 07/11/2021.
//  Copyright © 2021 Joao Nunes. All rights reserved.
//

import Foundation

open class ScheduledDepartureCommandOptions: Encodable {
    
    open var enable: Bool
    open var departureTime: Int
    open var preconditioningEnabled: Bool
    open var preconditioningWeekdaysOnly: Bool
    open var offPeakChargingEnabled: Bool
    open var endOffPeakTime: Int
    open var offPeakChargingWeekdaysOnly: Bool
    
    init(enable: Bool, departureTime: Int, preconditioningEnabled: Bool, preconditioningWeekdaysOnly: Bool, offPeakChargingEnabled: Bool, endOffPeakTime: Int, offPeakChargingWeekdaysOnly: Bool) {
        self.enable = enable
        self.departureTime = departureTime
        self.preconditioningEnabled = preconditioningEnabled
        self.preconditioningWeekdaysOnly = preconditioningWeekdaysOnly
        self.offPeakChargingEnabled = offPeakChargingEnabled
        self.endOffPeakTime = endOffPeakTime
        self.offPeakChargingWeekdaysOnly = offPeakChargingWeekdaysOnly
    }
    
    enum CodingKeys: String, CodingKey {
        case enable
        case departureTime = "departure_time"
        case preconditioningEnabled = "preconditioning_enabled"
        case preconditioningWeekdaysOnly = "preconditioning_weekdays_only"
        case offPeakChargingEnabled = "off_peak_charging_enabled"
        case endOffPeakTime = "end_off_peak_time"
        case offPeakChargingWeekdaysOnly = "off_peak_charging_weekdays_only"
    }
}

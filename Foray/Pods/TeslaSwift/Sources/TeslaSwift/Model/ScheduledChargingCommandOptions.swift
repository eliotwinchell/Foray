//
//  ScheduledChargingCommandOptions.swift
//  TeslaSwift
//
//  Created by Philip Engberg on 07/11/2021.
//  Copyright © 2021 Joao Nunes. All rights reserved.
//

import Foundation

open class ScheduledChargingCommandOptions: Encodable {
    
    open var enable: Bool
    open var time: Int
    
    init(enable: Bool, time: Int) {
        self.enable = enable
        self.time = time
    }
    
    enum CodingKeys: String, CodingKey {
        case enable
        case time
    }
}

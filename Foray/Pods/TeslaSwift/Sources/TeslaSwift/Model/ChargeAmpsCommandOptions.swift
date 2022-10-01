//
//  ChargeAmpsCommandOptions.swift
//  TeslaSwift
//
//  Created by João Nunes on 30/10/2021.
//  Copyright © 2021 Joao Nunes. All rights reserved.
//

import Foundation

open class ChargeAmpsCommandOptions: Encodable {

    open var amps: Int

    init(amps: Int) {
        self.amps = amps
    }

    enum CodingKeys: String, CodingKey {
        case amps = "charging_amps"
    }
}

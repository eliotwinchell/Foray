//
//  Charger.swift
//  Foray
//
//  Created by Eliot Winchell on 10/2/22.
//

import UIKit

struct Charger: Decodable {

    // MARK: - Properties

    let location: Array<Double>
    let id: Int
    let name: String
    let status: String
    let stallCount: Int
}

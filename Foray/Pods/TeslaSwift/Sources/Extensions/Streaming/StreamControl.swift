//
//  StreamControl.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 20/10/2019.
//  Copyright © 2019 Joao Nunes. All rights reserved.
//

import Foundation

class StreamAuthentication: Encodable {

    var messageType: String
    var token: String
    var value = "speed,odometer,soc,elevation,est_heading,est_lat,est_lng,power,shift_state,range,est_range,heading"
    var tag: String
    
    init?(type: TeslaStreamAuthenticationType, vehicleId: String) {
        switch type {
            case let .bearer(email, vehicleToken):
                self.messageType = "data:subscribe"
                if let token = "\(email):\(vehicleToken)".data(using: String.Encoding.utf8)?.base64EncodedString() {
                    self.token = token
                } else {
                    return nil
                }
            case let .oAuth(oAuthToken):
                self.messageType = "data:subscribe_oauth"
                self.token = "\(oAuthToken)"
        }

        self.tag = vehicleId
    }
    
    enum CodingKeys: String, CodingKey {
        case messageType = "msg_type"
        case token
        case value
        case tag
    }
}

class StreamMessage: Decodable {
    
    var messageType: String
    var value: String?
    var tag: String?
    var errorType: String?
    var connectionTimeout: Int?
    
    enum CodingKeys: String, CodingKey {
        case messageType = "msg_type"
        case value
        case tag
        case errorType = "error_type"
        case connectionTimeout = "connection_timeout"
    }
}

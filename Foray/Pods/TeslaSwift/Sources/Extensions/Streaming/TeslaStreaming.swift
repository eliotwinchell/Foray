//
//  TeslaStreaming.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 23/04/2017.
//  Copyright © 2017 Joao Nunes. All rights reserved.
//

import Foundation
import Starscream
#if COCOAPODS
#else // SPM
import TeslaSwift
#endif

enum TeslaStreamingError: Error {
    case streamingMissingVehicleTokenOrEmail
    case streamingMissingOAuthToken
}

enum TeslaStreamAuthenticationType {
    case bearer(String, String) // email, vehicleToken
    case oAuth(String) // oAuthToken
}

struct TeslaStreamAuthentication {

    let type: TeslaStreamAuthenticationType
    let vehicleId: String
    
    public init(type: TeslaStreamAuthenticationType, vehicleId: String) {
        self.type = type
        self.vehicleId = vehicleId
    }
}

/*
 * Streaming class takes care of the different types of data streaming from Tesla servers
 *
 */
public class TeslaStreaming {
    
    var debuggingEnabled: Bool {
        teslaSwift.debuggingEnabled
    }
    private var httpStreaming: WebSocket
    private var teslaSwift: TeslaSwift
    
    public init(teslaSwift: TeslaSwift) {
        httpStreaming = WebSocket(request: URLRequest(url: URL(string: "wss://streaming.vn.teslamotors.com/streaming/")!))
        self.teslaSwift = teslaSwift
    }

    /**
     Streams vehicle data

     - parameter vehicle: the vehicle that will receive the command
     - parameter reloadsVehicle: if you have a cached vehicle, the token might be expired, this forces a vehicle token reload
     - parameter dataReceived: callback to receive the websocket data
     */
    public func openStream(vehicle: Vehicle, reloadsVehicle: Bool = true, dataReceived: @escaping (TeslaStreamingEvent) -> Void) {

        if reloadsVehicle {

            reloadVehicle(vehicle: vehicle) { (result: Result<Vehicle, Error>) in
                switch result {
                    case .failure(let error):
                        dataReceived(TeslaStreamingEvent.error(error))
                    case .success(let freshVehicle):
                        self.startStream(vehicle: freshVehicle, dataReceived: dataReceived)
                }
            }

        } else {
            startStream(vehicle: vehicle, dataReceived: dataReceived)
        }

    }

    /**
     Stops the stream
     */
    public func closeStream() {
        httpStreaming.disconnect()
        logDebug("Stream closed", debuggingEnabled: self.debuggingEnabled)
    }

    private func reloadVehicle(vehicle: Vehicle, completion: @escaping (Result<Vehicle, Error>) -> ()) -> Void {

        teslaSwift.getVehicles { (result: Result<[Vehicle], Error>) in

            switch result {
                case .failure(let error):
                    completion(Result.failure(error))
                case .success(let vehicles):

                    for freshVehicle in vehicles where freshVehicle.vehicleID == vehicle.vehicleID {
                        completion(Result.success(freshVehicle))
                        return
                    }

                    completion(Result.failure(TeslaError.failedToReloadVehicle))
            }
        }
    }

    private func startStream(vehicle: Vehicle, dataReceived: @escaping (TeslaStreamingEvent) -> Void) {
        guard let accessToken = teslaSwift.token?.accessToken else {
            dataReceived(TeslaStreamingEvent.error(TeslaStreamingError.streamingMissingOAuthToken))
            return
        }
        let type: TeslaStreamAuthenticationType = .oAuth(accessToken)
        let authentication = TeslaStreamAuthentication(type: type, vehicleId: "\(vehicle.vehicleID!)")

        openStream(authentication: authentication, dataReceived: dataReceived)
    }
    
    private func openStream(authentication: TeslaStreamAuthentication, dataReceived: @escaping (TeslaStreamingEvent) -> Void) {
        
        let url = httpStreaming.request.url?.absoluteString
        
        logDebug("Opening Stream to: \(url ?? "")", debuggingEnabled: debuggingEnabled)

        httpStreaming.onEvent = {
            [weak self] event in
            guard let self = self else { return }

            switch event {
                case let .connected(headers):
                    DispatchQueue.main.async {

                        logDebug("Stream open headers: \(headers)", debuggingEnabled: self.debuggingEnabled)

                        if let authMessage = StreamAuthentication(type: authentication.type, vehicleId: authentication.vehicleId), let string = try? teslaJSONEncoder.encode(authMessage) {

                            self.httpStreaming.write(data: string)
                            dataReceived(TeslaStreamingEvent.open)
                        } else {
                            dataReceived(TeslaStreamingEvent.error(NSError(domain: "TeslaStreamingError", code: 0, userInfo: ["errorDescription" : "Failed to parse authentication data"])))
                            self.closeStream()
                        }
                    }
                case let .binary(data):
                    logDebug("Stream data: \(String(data: data, encoding: .utf8) ?? "")", debuggingEnabled: self.debuggingEnabled)

                    guard let message = try? teslaJSONDecoder.decode(StreamMessage.self, from: data) else { return }

                    DispatchQueue.main.async {
                        let type = message.messageType
                        switch type {
                            case "control:hello":
                                logDebug("Stream got hello", debuggingEnabled: self.debuggingEnabled)
                                break
                            case "data:update":
                                if let values = message.value {
                                    let event = StreamEvent(values: values)
                                    logDebug("Stream got data: \(values)", debuggingEnabled: self.debuggingEnabled)
                                    dataReceived(TeslaStreamingEvent.event(event))
                                }
                            case "data:error":
                                logDebug("Stream got data error: \(message.value ?? ""), \(message.errorType ?? "")", debuggingEnabled: self.debuggingEnabled)
                                dataReceived(TeslaStreamingEvent.error(NSError(domain: "TeslaStreamingError", code: 0, userInfo: [message.value ?? "error": message.errorType ?? ""])))
                                break
                            default:
                                break
                        }
                    }
                case let .disconnected(error, code):
                    DispatchQueue.main.async {
                        logDebug("Stream disconnected \(code):\(error)", debuggingEnabled: self.debuggingEnabled)
                        dataReceived(TeslaStreamingEvent.error(NSError(domain: "TeslaStreamingError", code: Int(code), userInfo: ["error": error])))
                    }
                case let .pong(data):
                    DispatchQueue.main.async {
                        logDebug("Stream Pong", debuggingEnabled: self.debuggingEnabled)
                        self.httpStreaming.write(pong: data ?? Data())
                    }
                case let .text(text):
                    logDebug("Stream Text: \(text)", debuggingEnabled: self.debuggingEnabled)
                case let .ping(ping):
                    logDebug("Stream ping: \(String(describing: ping))", debuggingEnabled: self.debuggingEnabled)
                case let .error(error):
                    DispatchQueue.main.async {
                        logDebug("Stream error:\(String(describing: error))", debuggingEnabled: self.debuggingEnabled)
                        dataReceived(TeslaStreamingEvent.error(NSError(domain: "TeslaStreamingError", code: 0, userInfo: ["error": error ?? ""])))
                    }
                case let .viabilityChanged(viability):
                    logDebug("Stream viabilityChanged: \(viability)", debuggingEnabled: self.debuggingEnabled)
                case let .reconnectSuggested(reconnect):
                    logDebug("Stream reconnectSuggested: \(reconnect)", debuggingEnabled: self.debuggingEnabled)
                case .cancelled:
                    logDebug("Stream cancelled", debuggingEnabled: self.debuggingEnabled)
            }
        }
		httpStreaming.connect()
	}

}

#if COCOAPODS
#else // SPM
func logDebug(_ format: String, debuggingEnabled: Bool) {
    if debuggingEnabled {
        print(format)
    }
}
#endif

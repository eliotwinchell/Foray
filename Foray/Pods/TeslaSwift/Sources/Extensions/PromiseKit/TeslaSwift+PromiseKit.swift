//
//  TeslaSwift+PromiseKit.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 09/07/2019.
//  Copyright © 2019 Joao Nunes. All rights reserved.
//

import Foundation
import PromiseKit
#if COCOAPODS
#else // SPM
import TeslaSwift
#endif

extension TeslaSwift {
    
    func promisify<Value: Decodable>(seal: Resolver<Value>) -> ((Swift.Result<Value, Error>) -> ()) {
        return { (result: Swift.Result<Value, Error>) in
            switch result {
            case .success(let value):
                seal.fulfill(value)
            case .failure(let error):
                seal.reject(error)
            }
            
        }
    }
    
    /**
     Revokes the stored token. Endpoint always returns true.
     
     - returns: A Promise with the token revoke state.
     */
    public func revokeWeb() -> Promise<Bool> {
        
        let (promise, seal) = Promise<Bool>.pending()
        
        revokeWeb(completion: promisify(seal: seal))
        
        return promise
        
    }
    
    /**
     Fetchs the list of your vehicles including not yet delivered ones
     
     - returns: A Promise with an array of Vehicles.
     */
    public func getVehicles() -> Promise<[Vehicle]> {
        
        let (promise, seal) = Promise<[Vehicle]>.pending()
        
        getVehicles(completion: promisify(seal: seal))
        
        return promise
    }

    public func getVehicle(_ vehicleID: String) -> Promise<Vehicle> {
        
        let (promise, seal) = Promise<Vehicle>.pending()
        
        getVehicle(vehicleID, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    public func getVehicle(_ vehicle: Vehicle) -> Promise<Vehicle> {
        
        let (promise, seal) = Promise<Vehicle>.pending()
        
        getVehicle(vehicle, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    public func getAllData(_ vehicle: Vehicle) -> Promise<VehicleExtended> {
        
        let (promise, seal) = Promise<VehicleExtended>.pending()
        
        getAllData(vehicle, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    public func getVehicleMobileAccessState(_ vehicle: Vehicle) -> Promise<Bool> {
        
        let (promise, seal) = Promise<Bool>.pending()
        
        getVehicleMobileAccessState(vehicle, completion: promisify(seal: seal))
        
        return promise
    }
    
    /**
     Fetchs the vehicle charge state
     
     - returns: A Promise with charge state.
     */
    public func getVehicleChargeState(_ vehicle: Vehicle) -> Promise<ChargeState> {
        
        let (promise, seal) = Promise<ChargeState>.pending()
        
        getVehicleChargeState(vehicle, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    /**
     Fetchs the vehicle Climate state
     
     - returns: A Promise with Climate state.
     */
    public func getVehicleClimateState(_ vehicle: Vehicle) -> Promise<ClimateState> {
        
        let (promise, seal) = Promise<ClimateState>.pending()
        
        getVehicleClimateState(vehicle, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    /**
     Fetchs the vehicledrive state
     
     - returns: A Promise with drive state.
     */
    public func getVehicleDriveState(_ vehicle: Vehicle) -> Promise<DriveState> {
        
        let (promise, seal) = Promise<DriveState>.pending()
        
        getVehicleDriveState(vehicle, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    /**
     Fetchs the vehicle Gui Settings
     
     - returns: A Promise with Gui Settings.
     */
    public func getVehicleGuiSettings(_ vehicle: Vehicle) -> Promise<GuiSettings> {
        
        let (promise, seal) = Promise<GuiSettings>.pending()
        
        getVehicleGuiSettings(vehicle, completion: promisify(seal: seal))
        
        return promise
    }
    
    /**
     Fetchs the vehicle state
     
     - returns: A Promise with vehicle state.
     */
    public func getVehicleState(_ vehicle: Vehicle) -> Promise<VehicleState> {
        
        let (promise, seal) = Promise<VehicleState>.pending()
        
        getVehicleState(vehicle, completion: promisify(seal: seal))
        
        return promise
    }
    
    /**
     Fetchs the vehicle config
     
     - returns: A Promise with vehicle config
     */
    public func getVehicleConfig(_ vehicle: Vehicle) -> Promise<VehicleConfig> {
        
        let (promise, seal) = Promise<VehicleConfig>.pending()
        
        getVehicleConfig(vehicle, completion: promisify(seal: seal))
        
        return promise
    }
    
    /**
     Fetches the nearby charging sites
     
     - parameter vehicle: the vehicle to get nearby charging sites from
     - returns: A Promise with nearby charging sites
     */
    public func getNearbyChargingSites(_ vehicle: Vehicle) -> Promise<NearbyChargingSites> {
        
        let (promise, seal) = Promise<NearbyChargingSites>.pending()
        
        getNearbyChargingSites(vehicle, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    /**
     Wakes up the vehicle
     
     - returns: A Promise with the current Vehicle
     */
    public func wakeUp(vehicle: Vehicle) -> Promise<Vehicle> {
        
        let (promise, seal) = Promise<Vehicle>.pending()
        
        wakeUp(vehicle, completion: promisify(seal: seal))
        
        return promise
        
    }
    
    /**
     Sends a command to the vehicle
     
     - parameter vehicle: the vehicle that will receive the command
     - parameter command: the command to send to the vehicle
     - returns: A Promise with the CommandResponse object containing the results of the command.
     */
    public func sendCommandToVehicle(_ vehicle: Vehicle, command: VehicleCommand) -> Promise<CommandResponse> {
        
        let (promise, seal) = Promise<CommandResponse>.pending()
        
        sendCommandToVehicle(vehicle, command: command, completion: promisify(seal: seal))
        
        return promise
    }
    
    public func getProducts() -> Promise<[Product]> {
        
        let (promise, seal) = Promise<[Product]>.pending()
        
        getProducts(completion: promisify(seal: seal))
        
        return promise
    }
        
    public func getEnergySiteStatus(siteID: String) -> Promise<EnergySiteStatus> {
        
        let (promise, seal) = Promise<EnergySiteStatus>.pending()
        
        getEnergySiteStatus(siteID: siteID, completion: promisify(seal: seal))
        
        return promise
    }

    public func getEnergySiteLiveStatus(siteID: String) -> Promise<EnergySiteLiveStatus> {
        
        let (promise, seal) = Promise<EnergySiteLiveStatus>.pending()
        
        getEnergySiteLiveStatus(siteID: siteID, completion: promisify(seal: seal))
        
        return promise
    }

    public func getEnergySiteInfo(siteID: String) -> Promise<EnergySiteInfo> {
        
        let (promise, seal) = Promise<EnergySiteInfo>.pending()
        
        getEnergySiteInfo(siteID: siteID, completion: promisify(seal: seal))
        
        return promise
    }

    public func getEnergySiteHistory(siteID: String, period: EnergySiteHistory.Period) -> Promise<EnergySiteHistory> {
        
        let (promise, seal) = Promise<EnergySiteHistory>.pending()
        
        getEnergySiteHistory(siteID: siteID, period: period, completion: promisify(seal: seal))
        
        return promise
    }

    public func getBatteryStatus(batteryID: String) -> Promise<BatteryStatus> {
        
        let (promise, seal) = Promise<BatteryStatus>.pending()
        
        getBatteryStatus(batteryID: batteryID, completion: promisify(seal: seal))
        
        return promise
    }

    public func getBatteryData(batteryID: String) -> Promise<BatteryData> {
        
        let (promise, seal) = Promise<BatteryData>.pending()
        
        getBatteryData(batteryID: batteryID, completion: promisify(seal: seal))
        
        return promise
    }

    public func getBatteryPowerHistory(batteryID: String) -> Promise<BatteryPowerHistory> {
        
        let (promise, seal) = Promise<BatteryPowerHistory>.pending()
        
        getBatteryPowerHistory(batteryID: batteryID, completion: promisify(seal: seal))
        
        return promise
    }

}

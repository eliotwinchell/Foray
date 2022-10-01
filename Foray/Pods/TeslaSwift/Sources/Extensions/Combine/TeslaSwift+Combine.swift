//
//  TeslaSwift+Combine.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 08/07/2019.
//  Copyright © 2019 Joao Nunes. All rights reserved.
//

#if swift(>=5.1)
import Combine
#if COCOAPODS
#else // SPM
import TeslaSwift
#endif

extension TeslaSwift {
    
    func resultify<Value: Decodable>(subscriber: @escaping (Result<Value, Error>) -> Void) -> ((Result<Value, Error>) -> ()) {
        
        return { (result: Result<Value, Error>) in
            
            switch result {
            case .success(let value):
                subscriber(.success(value))
            case .failure(let error):
                subscriber(.failure(error))
            }
        }
        
    }
    
    public func revokeWeb() -> Future<Bool, Error> {
        
        let future = Future<Bool,Error> { (subscriber: @escaping (Result<Bool, Error>) -> Void) in
            
            self.revokeWeb(completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicles() -> Future<[Vehicle], Error> {
        
        let future = Future<[Vehicle],Error> { (subscriber: @escaping (Result<[Vehicle], Error>) -> Void) in
            
            self.getVehicles(completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicle(_ vehicleID: String) -> Future<Vehicle, Error> {
           
           let future = Future<Vehicle,Error> { (subscriber: @escaping (Result<Vehicle, Error>) -> Void) in
               
               self.getVehicle(vehicleID, completion: self.resultify(subscriber: subscriber))
               
           }
           
           return future
       }
    
    public func getVehicle(_ vehicle: Vehicle) -> Future<Vehicle, Error> {
        
        let future = Future<Vehicle,Error> { (subscriber: @escaping (Result<Vehicle, Error>) -> Void) in
            
            self.getVehicle(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getAllData(_ vehicle: Vehicle) -> Future<VehicleExtended, Error> {
        
        let future = Future<VehicleExtended,Error> { (subscriber: @escaping (Result<VehicleExtended, Error>) -> Void) in
            
            self.getAllData(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicleMobileAccessState(_ vehicle: Vehicle) -> Future<Bool, Error> {
        
        let future = Future<Bool,Error> { (subscriber: @escaping (Result<Bool, Error>) -> Void) in
            
            self.getVehicleMobileAccessState(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicleChargeState(_ vehicle: Vehicle) -> Future<ChargeState, Error> {
        
        let future = Future<ChargeState,Error> { (subscriber: @escaping (Result<ChargeState, Error>) -> Void) in
            
            self.getVehicleChargeState(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicleClimateState(_ vehicle: Vehicle) -> Future<ClimateState, Error> {
        
        let future = Future<ClimateState,Error> { (subscriber: @escaping (Result<ClimateState, Error>) -> Void) in
            
            self.getVehicleClimateState(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicleDriveState(_ vehicle: Vehicle) -> Future<DriveState, Error> {
        
        let future = Future<DriveState,Error> { (subscriber: @escaping (Result<DriveState, Error>) -> Void) in
            
            self.getVehicleDriveState(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicleGuiSettings(_ vehicle: Vehicle) -> Future<GuiSettings, Error> {
        
        let future = Future<GuiSettings,Error> { (subscriber: @escaping (Result<GuiSettings, Error>) -> Void) in
            
            self.getVehicleGuiSettings(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicleState(_ vehicle: Vehicle) -> Future<VehicleState, Error> {
        
        let future = Future<VehicleState,Error> { (subscriber: @escaping (Result<VehicleState, Error>) -> Void) in
            
            self.getVehicleState(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getVehicleConfig(_ vehicle: Vehicle) -> Future<VehicleConfig, Error> {
        
        let future = Future<VehicleConfig,Error> { (subscriber: @escaping (Result<VehicleConfig, Error>) -> Void) in
            
            self.getVehicleConfig(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func wakeUp(_ vehicle: Vehicle) -> Future<Vehicle, Error> {
        
        let future = Future<Vehicle,Error> { (subscriber: @escaping (Result<Vehicle, Error>) -> Void) in
            
            self.wakeUp(vehicle, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func sendCommandToVehicle(_ vehicle: Vehicle, command: VehicleCommand) -> Future<CommandResponse, Error> {
        
        let future = Future<CommandResponse,Error> { (subscriber: @escaping (Result<CommandResponse, Error>) -> Void) in
            
            self.sendCommandToVehicle(vehicle, command: command, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getProducts() -> Future<[Product], Error> {
        
        let future = Future<[Product], Error> { (subscriber: @escaping (Result<[Product], Error>) -> Void) in
            
            self.getProducts(completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
    
    public func getEnergySiteStatus(siteID: String) -> Future<EnergySiteStatus, Error> {
        
        let future = Future<EnergySiteStatus, Error> { (subscriber: @escaping (Result<EnergySiteStatus, Error>) -> Void) in
            
            self.getEnergySiteStatus(siteID: siteID, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }

    public func getEnergySiteLiveStatus(siteID: String) -> Future<EnergySiteLiveStatus, Error> {
        
        let future = Future<EnergySiteLiveStatus, Error> { (subscriber: @escaping (Result<EnergySiteLiveStatus, Error>) -> Void) in
            
            self.getEnergySiteLiveStatus(siteID: siteID, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }

    public func getEnergySiteInfo(siteID: String) -> Future<EnergySiteInfo, Error> {
        
        let future = Future<EnergySiteInfo, Error> { (subscriber: @escaping (Result<EnergySiteInfo, Error>) -> Void) in
            
            self.getEnergySiteInfo(siteID: siteID, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }

    public func getEnergySiteHistory(siteID: String, period: EnergySiteHistory.Period) -> Future<EnergySiteHistory, Error> {
        
        let future = Future<EnergySiteHistory, Error> { (subscriber: @escaping (Result<EnergySiteHistory, Error>) -> Void) in
            
            self.getEnergySiteHistory(siteID: siteID, period: period, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }

    public func getBatteryStatus(batteryID: String) -> Future<BatteryStatus, Error> {
        
        let future = Future<BatteryStatus, Error> { (subscriber: @escaping (Result<BatteryStatus, Error>) -> Void) in
            
            self.getBatteryStatus(batteryID: batteryID, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }

    public func getBatteryData(batteryID: String) -> Future<BatteryData, Error> {
        
        let future = Future<BatteryData, Error> { (subscriber: @escaping (Result<BatteryData, Error>) -> Void) in
            
            self.getBatteryData(batteryID: batteryID, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }

    public func getBatteryPowerHistory(batteryID: String) -> Future<BatteryPowerHistory, Error> {
        
        let future = Future<BatteryPowerHistory, Error> { (subscriber: @escaping (Result<BatteryPowerHistory, Error>) -> Void) in
            
            self.getBatteryPowerHistory(batteryID: batteryID, completion: self.resultify(subscriber: subscriber))
            
        }
        
        return future
    }
}

#endif

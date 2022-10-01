//
//  TeslaSwift+Combine.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 08/07/2019.
//  Copyright © 2019 Joao Nunes. All rights reserved.
//

import Foundation
import RxSwift
#if COCOAPODS
#else // SPM
import TeslaSwift
#endif

extension TeslaSwift {
    
    func singlefy<Value: Decodable>(subscriber: @escaping (SingleEvent<Value>) -> Void) -> ((Result<Value, Error>) -> ()) {
        
        return { (result: Result<Value, Error>) in
            
            switch result {
            case .success(let value):
                subscriber(.success(value))
            case .failure(let error):
                subscriber(.failure(error))
            }
        }
        
    }
    
    public func revokeWeb() -> Single<Bool> {
        
        let future = Single<Bool>.create { (single: @escaping (SingleEvent<Bool>) -> Void) -> Disposable in
            
            self.revokeWeb(completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicles() -> Single<[Vehicle]> {
        
        let future = Single<[Vehicle]>.create { (single: @escaping (SingleEvent<[Vehicle]>) -> Void) -> Disposable in
            
            self.getVehicles(completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicle(_ vehicleID: String) -> Single<Vehicle> {
        
        let future = Single<Vehicle>.create { (single: @escaping (SingleEvent<Vehicle>) -> Void) -> Disposable in
            
            self.getVehicle(vehicleID, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicle(_ vehicle: Vehicle) -> Single<Vehicle> {
        
        let future = Single<Vehicle>.create { (single: @escaping (SingleEvent<Vehicle>) -> Void) -> Disposable in
            
            self.getVehicle(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getAllData(_ vehicle: Vehicle) -> Single<VehicleExtended> {
        
        let future = Single<VehicleExtended>.create { (single: @escaping (SingleEvent<VehicleExtended>) -> Void) -> Disposable in
            
            self.getAllData(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicleMobileAccessState(_ vehicle: Vehicle) -> Single<Bool> {
        
        let future = Single<Bool>.create { (single: @escaping (SingleEvent<Bool>) -> Void) -> Disposable in
            
            self.getVehicleMobileAccessState(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicleChargeState(_ vehicle: Vehicle) -> Single<ChargeState> {
        
        let future = Single<ChargeState>.create { (single: @escaping (SingleEvent<ChargeState>) -> Void) -> Disposable in
            
            self.getVehicleChargeState(vehicle, completion: self.singlefy(subscriber: single))
         
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicleChargeState(_ vehicle: Vehicle) -> Single<ClimateState> {
        
        let future = Single<ClimateState>.create { (single: @escaping (SingleEvent<ClimateState>) -> Void) -> Disposable in
            
            self.getVehicleClimateState(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicleDriveState(_ vehicle: Vehicle) -> Single<DriveState> {
        
        let future = Single<DriveState>.create { (single: @escaping (SingleEvent<DriveState>) -> Void) -> Disposable in
            
            self.getVehicleDriveState(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicleGuiSettings(_ vehicle: Vehicle) -> Single<GuiSettings> {
        
        let future = Single<GuiSettings>.create { (single: @escaping (SingleEvent<GuiSettings>) -> Void) -> Disposable in
            
            self.getVehicleGuiSettings(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicleState(_ vehicle: Vehicle) -> Single<VehicleState> {
        
        let future = Single<VehicleState>.create { (single: @escaping (SingleEvent<VehicleState>) -> Void) -> Disposable in
            
            self.getVehicleState(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getVehicleConfig(_ vehicle: Vehicle) -> Single<VehicleConfig> {
        
        let future = Single<VehicleConfig>.create { (single: @escaping (SingleEvent<VehicleConfig>) -> Void) -> Disposable in
            
            self.getVehicleConfig(vehicle, completion: self.singlefy(subscriber: single))
         
            return Disposables.create { }
        }
        
        return future
    }
    
    public func wakeUp(_ vehicle: Vehicle) -> Single<Vehicle> {
        
        let future = Single<Vehicle>.create { (single: @escaping (SingleEvent<Vehicle>) -> Void) -> Disposable in
            
            self.wakeUp(vehicle, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func sendCommandToVehicle(_ vehicle: Vehicle, command: VehicleCommand) -> Single<CommandResponse> {
        
        let future = Single<CommandResponse>.create { (single: @escaping (SingleEvent<CommandResponse>) -> Void) -> Disposable in
            
            self.sendCommandToVehicle(vehicle, command: command, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
    
    public func getProducts() -> Single<[Product]> {
        
        let future = Single<[Product]>.create { (single: @escaping (SingleEvent<[Product]>) -> Void) -> Disposable in
            self.getProducts(completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }
        
    public func getEnergySiteStatus(siteID: String) -> Single<EnergySiteStatus> {
        
        let future = Single<EnergySiteStatus>.create { (single: @escaping (SingleEvent<EnergySiteStatus>) -> Void) -> Disposable in
            self.getEnergySiteStatus(siteID: siteID, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }

    public func getEnergySiteLiveStatus(siteID: String) -> Single<EnergySiteLiveStatus> {
        
        let future = Single<EnergySiteLiveStatus>.create { (single: @escaping (SingleEvent<EnergySiteLiveStatus>) -> Void) -> Disposable in
            self.getEnergySiteLiveStatus(siteID: siteID, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }

    public func getEnergySiteInfo(siteID: String) -> Single<EnergySiteInfo> {
        
        let future = Single<EnergySiteInfo>.create { (single: @escaping (SingleEvent<EnergySiteInfo>) -> Void) -> Disposable in
            self.getEnergySiteInfo(siteID: siteID, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }

    public func getEnergySiteHistory(siteID: String, period: EnergySiteHistory.Period) -> Single<EnergySiteHistory> {
        
        let future = Single<EnergySiteHistory>.create { (single: @escaping (SingleEvent<EnergySiteHistory>) -> Void) -> Disposable in
            self.getEnergySiteHistory(siteID: siteID, period: period, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }

    public func getBatteryStatus(batteryID: String) -> Single<BatteryStatus> {
        
        let future = Single<BatteryStatus>.create { (single: @escaping (SingleEvent<BatteryStatus>) -> Void) -> Disposable in
            self.getBatteryStatus(batteryID: batteryID, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }

    public func getBatteryData(batteryID: String) -> Single<BatteryData> {
        
        let future = Single<BatteryData>.create { (single: @escaping (SingleEvent<BatteryData>) -> Void) -> Disposable in
            self.getBatteryData(batteryID: batteryID, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }

    public func getBatteryPowerHistory(batteryID: String) -> Single<BatteryPowerHistory> {
        
        let future = Single<BatteryPowerHistory>.create { (single: @escaping (SingleEvent<BatteryPowerHistory>) -> Void) -> Disposable in
            self.getBatteryPowerHistory(batteryID: batteryID, completion: self.singlefy(subscriber: single))
            
            return Disposables.create { }
        }
        
        return future
    }

}

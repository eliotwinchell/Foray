//
//  RoutingVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import Foundation
import UIKit
import MapKit
import TeslaSwift
import NotificationBannerSwift

class RoutingVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var mapView: MKMapView!
    
    private var networkVehicle: Vehicle?
    private var vehicleLocation: DriveState? {
        didSet {
            let initialLocation = CLLocation(latitude: vehicleLocation?.latitude ?? 35.2785431, longitude: vehicleLocation?.longitude ?? -120.7514578)
            let vehiclePin = VehiclePin(
                coordinate: CLLocationCoordinate2D(latitude: vehicleLocation?.latitude ?? 35.2785431, longitude: vehicleLocation?.longitude ?? -120.75145781))
            
            DispatchQueue.main.async {
                self.mapView.centerToLocation(initialLocation)
                self.mapView.addAnnotation(vehiclePin)
            }
        }
    }
    
    var searchBar: UISearchBar? = nil
    var vehicleID: String = ""
    var api: TeslaSwift!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        view.backgroundColor = CustomColor.customBackgroundColor
        
        let defaults = UserDefaults.standard
        vehicleID = defaults.string(forKey: "vehicleID") ?? "NA"
        
        view.backgroundColor = .black
        mapView.layer.cornerRadius = 45
        
        self.getVehicle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //Assign Delegate and blank the search bar text
        searchBar?.text = ""
        searchBar?.delegate = self

    }
        
    private func getVehicle() {
        DispatchQueue.main.async{
            self.api.getVehicle(self.vehicleID) { (result: Result<Vehicle, Error>) in
                switch result {
                    case .success(let networkVehicle):
                        self.networkVehicle = networkVehicle
                        self.getLocation()
                        
                        print("successfully loaded network vehicle")
                    case .failure(let error):
                        print("failure to auth API")
                        print(error.localizedDescription)
                        DispatchQueue.main.async{
                            let banner = StatusBarNotificationBanner(title: "Unable to connect to Tesla's Network", style: .danger)
                            banner.show()
                        }
                }
            }
        }
    }
    
    private func getLocation() {
        DispatchQueue.main.async{
            self.api.getVehicleDriveState(self.networkVehicle!) { (result: Result<DriveState, Error>) in
            switch result {
                case .success(let driveState):
                    self.vehicleLocation = driveState
                    
                    print("successfully loaded network vehicle")
                case .failure(let error):
                    print("failure to auth API")
                    print(error.localizedDescription)
                    DispatchQueue.main.async{
                        let banner = StatusBarNotificationBanner(title: "Unable to connect to Tesla's Network", style: .danger)
                        banner.show()
                    }
            }
        }
    }
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 5000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension RoutingVC: MKMapViewDelegate {
  // 1
  func mapView(
    _ mapView: MKMapView,
    viewFor annotation: MKAnnotation
  ) -> MKAnnotationView? {
    // 2
    guard let annotation = annotation as? VehiclePin else {
      return nil
    }
    // 3
    let identifier = "vehiclepin"
    var view: MKMarkerAnnotationView
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(
      withIdentifier: identifier) as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5
      view = MKMarkerAnnotationView(
        annotation: annotation,
        reuseIdentifier: identifier)
        view.canShowCallout = false
        
    }
    return view
  }
}

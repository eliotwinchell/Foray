//
//  VehiclePin.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import Foundation
import MapKit

class VehiclePin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let identifier = "vehicle-pin"
    let image: UIImage?

  init(
    coordinate: CLLocationCoordinate2D
  ) {
    self.coordinate = coordinate
    self.image = UIImage(named: "vehicle-icon")
    
    super.init()
  }
}

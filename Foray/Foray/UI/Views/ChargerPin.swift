//
//  ChargerPin.swift
//  Foray
//
//  Created by Eliot Winchell on 10/2/22.
//

import Foundation
import MapKit

class ChargerPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let identifier: Int
    let subtitle: String?
    let glyphImage: UIImage?

  init(
    coordinate: CLLocationCoordinate2D, identifier: Int, subtitle: String
  ) {
    self.coordinate = coordinate
    self.identifier = identifier
    self.subtitle = subtitle
    self.glyphImage = UIImage(named: "charger-pin")
    
    super.init()
  }
}

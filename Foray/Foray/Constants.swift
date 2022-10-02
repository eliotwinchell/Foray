//
//  Constants.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import NotificationCenter

let refreshVehicleDataKey = "com.teslakeychain.teslakeychain.ios.refreshVehicleData"

enum CustomColor {
    static let customBackgroundColor = UIColor(named: "BackgroundColor")
    static let customTransparentColor = UIColor(white: 0.0, alpha: 0.0)
}

enum Segue {
    static let home = "homeSegue"
    static let login = "loginSegue"
    static let postLogin = "postLoginSegue"
    static let noVehicle = "noVehicleSegue"
    static let rootVc = "rootVcSegue"
    static let toLoginFromNoVehicle = "toLoginFromNoVehicleSegue"
    static let loadingScreen = "loadingScreenSegue"
    static let returnNoVehicle = "returnNoVehicleSegue"
    static let tabBar = "tabBarSegue"
    static let stream = "streamSegue"
}

extension Notification.Name {
    static let vehicleUpdated = Notification.Name("vehicleUpdated")
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

//
//  LoginVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import Foundation
import UIKit
import TeslaSwift

extension Notification.Name {
    static let loginDone = Notification.Name("loginDone")
}

class LoginVC: UIViewController {
    @IBOutlet weak var appTitle: UILabel!
    var api: TeslaSwift!

    @IBAction func webLoginAction(_ sender: AnyObject) {
        if #available(iOS 13.0, *) {
            
            let webloginViewController = api.authenticateWeb {(result: Result<AuthToken, Error>) in

                switch result {
                    case .success(let token):
                        let encoder = JSONEncoder()

                        if let encoded = try? encoder.encode(token) {
                            let defaults = UserDefaults.standard
                            defaults.set(encoded, forKey: "authtoken")
                        }
                        
                        // issue here: If we're offline, the api will fail. Won't load offline app.. maybe need to move this logic
                        self.api.getVehicles { (result: Result<[Vehicle], Error>) in
                            switch result {
                                case .success(let vehicles):
                                    if (vehicles.isEmpty) {
                                        // If we don't have a vehicle, then go into the vehicle empty screen. How do we update this so we re-check when a vehicle is added??
                                        
                                        DispatchQueue.main.async {
                                            self.performSegue(withIdentifier: Segue.noVehicle, sender: self)
                                        }
                                    } else {
                                        let defaults = UserDefaults.standard
                                        defaults.set(vehicles[0].id!, forKey: "vehicleID")
                                        print("Our vehicle ID is: %@", vehicles[0].id ?? "N/A")
                                        
                                        // ISSUE HERE: We could be saving the vehicle but trying to load it in the home VC before it's saved?
                                        DispatchQueue.main.async {
                                            self.performSegue(withIdentifier: Segue.home, sender: self)
                                        }
                                    }
                                case .failure(let error):
                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: Segue.loadingScreen, sender: self)
                                    }
                                    print(error)
                            }

                        }
                        
                    case .failure(let error):
                        print("Authentication failed: \(error)")
                }
                
            }
            
            guard let safeWebloginViewController = webloginViewController else { return }

            self.present(safeWebloginViewController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == Segue.home {
            let navigationVC = segue.destination as! NavigationVC
            let tabBarVC = navigationVC.topViewController as! TabBarVC
            let homeVC = tabBarVC.viewControllers?[0] as! RoutingVC
            
            homeVC.api = self.api
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        view.backgroundColor = CustomColor.customBackgroundColor
    }

}

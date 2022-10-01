//
//  LoadingVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import UIKit
import TeslaSwift

class LoadingVC: UIViewController {

    //
    // MARK: - Properties
    //
    fileprivate var authSuccessful: Bool = false
    fileprivate let runCountNamespace = "runCount" // not sure what this is for?
    private var api = TeslaSwift()

    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        view.backgroundColor = CustomColor.customBackgroundColor

        self.api.debuggingEnabled = true
        
        self.checkForToken()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == Segue.home {
            let navigationVC = segue.destination as! NavigationController
            let tabBarVC = navigationVC.topViewController as! TabBarVC
            let homeVC = tabBarVC.viewControllers?[0] as! HomeVC
            let tripPlannerVC = tabBarVC.viewControllers?[1] as! TripPlannerVC
            let settingsVC = tabBarVC.viewControllers?[3] as! SettingsListVC
            
            homeVC.api = self.api
            tripPlannerVC.api = self.api
            settingsVC.api = self.api
        }
        
        if segue.identifier == Segue.login {
            let lvc = segue.destination as! LoginVC
            lvc.api = self.api
        }
        
        if segue.identifier == Segue.stream {
            let svc = segue.destination as! StreamVC
            svc.vehicle = self.api.getVehicles()
            svc.api = self.api
        }
    }
    
    private func checkForToken() {
        let defaults = UserDefaults.standard
        
        if let decoded = defaults.object(forKey: "authtoken") as? Data {
            let decoder = JSONDecoder()
            
            if let loadedToken = try? decoder.decode(AuthToken.self, from: decoded) {
                api.reuse(token: loadedToken)
                
                if (loadedToken.isValid) {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: Segue.stream, sender: self)
                    }
                } else {
                    // Try to refresh the web token before going to the login screen
                    // This could take some time, need a better loading icon
                    // Or do we move the token refresh to the home screen??
                    api.refreshWebToken { (result: Result<AuthToken, Error>) in
                        switch result {
                        case .success(_):
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: Segue.stream, sender: self)
                            }
                        case .failure(_):
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: Segue.login, sender: self)
                            }
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Segue.login, sender: self)
                print("No auth token stored, lets perform a login attempt")
            }
        }
    }
}

//if self.authSuccessful {
//    self.dismiss(animated: false, completion: {
//        let nc = NavigationController()
//        nc.data = self.data
//        pvc?.present(nc, animated: false, completion: nil)
//    })
//} else {
//    self.dismiss(animated: false, completion: {
//        let lvc = LoginViewController()
//        pvc?.present(lvc, animated: false, completion: nil)
//    })
//}

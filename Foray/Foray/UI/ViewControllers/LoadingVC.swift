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
            let navigationVC = segue.destination as! NavigationVC
            let tabBarVC = navigationVC.topViewController as! TabBarVC
            let homeNCVC = tabBarVC.viewControllers?[0] as! UINavigationController
            let homeVC = homeNCVC.topViewController as! RoutingVC
            let settingsVC = tabBarVC.viewControllers?[2] as! SettingsVC
            
            homeVC.api = self.api
            settingsVC.api = self.api
        }
        
        if segue.identifier == Segue.login {
            let lvc = segue.destination as! LoginVC
            lvc.api = self.api
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
                        self.performSegue(withIdentifier: Segue.home, sender: self)
                    }
                } else {
                    // Try to refresh the web token before going to the login screen
                    // This could take some time, need a better loading icon
                    // Or do we move the token refresh to the home screen??
                    api.refreshWebToken { (result: Result<AuthToken, Error>) in
                        switch result {
                        case .success(_):
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: Segue.home, sender: self)
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

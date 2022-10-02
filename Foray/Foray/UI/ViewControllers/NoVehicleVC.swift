//
//  NoVehicleVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import UIKit
import TeslaSwift

class NoVehicleVC: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = CustomColor.customBackgroundColor
            
    }
    
    @IBAction func buttonPress(_ sender: Any) {

    }
    
}

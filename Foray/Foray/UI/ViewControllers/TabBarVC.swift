//
//  TabBarVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import UIKit
import TeslaSwift

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let heightAdjusted = 100.0

        tabBar.frame.size.height = heightAdjusted
        tabBar.frame.origin.y = view.frame.height - heightAdjusted
        
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}

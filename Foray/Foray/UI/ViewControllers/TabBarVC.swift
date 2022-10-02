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
//        if (segue.identifier == Segue.homeFromTab) {
//            let hvc = segue.destination as! HomeVC
//            hvc.api = self.api
//            print("set api for HVC")
//        }
//
//        if (segue.identifier == Segue.tripPlanner) {
//            let tpvc = segue.destination as! TripPlannerVC
//            tpvc.api = self.api
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

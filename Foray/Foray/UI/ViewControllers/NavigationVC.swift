//
//  NavigationVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import UIKit
import TeslaSwift

protocol NavigationControllerDelegate: AnyObject {
    func navigationControllerDidTapMenuButton(_ rootViewController: NavigationVC)
}

class NavigationVC: UINavigationController, UINavigationControllerDelegate {
    fileprivate var menuButton: UIBarButtonItem!
    fileprivate var topNavigationLeftImage: UIImage?
    weak var drawerDelegate: NavigationControllerDelegate?
    
    var api: TeslaSwift!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        view.backgroundColor = CustomColor.customTransparentColor
        view.isOpaque = false
        
        overrideUserInterfaceStyle = .dark
        self.navigationBar.backgroundColor = CustomColor.customTransparentColor
        self.navigationBar.barTintColor = CustomColor.customTransparentColor
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()

//        self.topNavigationLeftImage = UIImage(named: "garage-icon")
//        self.menuButton = UIBarButtonItem(image: UIImage(named: "garage-icon"), style: .plain, target: self, action: #selector(handleMenuButton))
//        self.navigationBar.topItem!.leftBarButtonItem = self.menuButton
        
//        let menuVC = MenuViewController()
//        menuVC.view.backgroundColor = .green
//
//        let drawerVC = DrawerController(navigationController: self, menuController: menuVC)
//        drawerVC.didMove(toParent: self)
//

        self.navigationBar.layoutIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.tabBar {
//            print("Called TabBar Segue!")
//            let barViewController = segue.destination as! TabBarVC
//            let destinationViewController = barViewController.viewControllers?[0] as! HomeVC
//            print("vcs")
//            print(barViewController.viewControllers)
//            let secondVC = barViewController.viewControllers?[3] as! SettingsListVC
//            destinationViewController.api = self.api
//            secondVC.api = self.api
            
        }

    }
}

extension NavigationVC {
    @objc fileprivate func handleMenuButton() {
        drawerDelegate?.navigationControllerDidTapMenuButton(self)
    }
}

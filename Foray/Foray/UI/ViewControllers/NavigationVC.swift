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

        self.navigationBar.layoutIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.tabBar {

        }

    }
}

extension NavigationVC {
    @objc fileprivate func handleMenuButton() {
        drawerDelegate?.navigationControllerDidTapMenuButton(self)
    }
}

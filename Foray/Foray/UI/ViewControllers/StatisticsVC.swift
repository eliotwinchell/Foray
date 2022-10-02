//
//  StatisticsVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import Foundation
import UIKit

class Statistics: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var firstGraph: UIView!
    
    @IBOutlet var secondGraph: UIView!
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        
        self.scrollView.backgroundColor = CustomColor.customBackgroundColor
        self.mainView.layer.cornerRadius = 45
        self.mainView.backgroundColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

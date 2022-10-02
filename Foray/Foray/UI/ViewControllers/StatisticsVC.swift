//
//  StatisticsVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import Foundation
import UIKit

class StatisticsVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
     
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        
        self.scrollView.backgroundColor = .gray
        self.mainView.layer.cornerRadius = 45
        self.mainView.backgroundColor = .gray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

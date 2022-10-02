//
//  SettingsVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import Foundation
import UIKit
import TeslaSwift

class SettingsVC: UITableViewController {
    let settingsList = ["Dark Mode"]
    
    var api: TeslaSwift!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        view.backgroundColor = CustomColor.customBackgroundColor
        
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        
        self.tableView.backgroundColor = CustomColor.customBackgroundColor
        self.tableView.layer.cornerRadius = 45

    }
     
    @IBAction func signOutAction(_ sender: Any) {
        //api.logout() this crashes the app?
        print("sign out")
    }
}

extension SettingsVC {
    static let settingsListCellIdentifier = "SettingListCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsVC.settingsListCellIdentifier, for: indexPath) as?  SettingListCell else {
            fatalError("Unable to dequeue ReminderCell")
        }
        
        let setting = settingsList[indexPath.row]
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = setting
            
            cell.contentConfiguration = content
        } else {
            // Fallback on earlier versions
            cell.titleLabel.text = setting
        }
        
        return cell
    }
}

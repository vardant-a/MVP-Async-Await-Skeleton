//
//  SettingsCell.swift
//  MVP_Project
//
//  Created by Aleksei on 29.05.2023.
//

import UIKit

protocol SettingsCell: AnyObject {
    var cellID: String { get }
    var height: CGFloat { get }
    
    func register(for tableView: UITableView)
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

struct SettingsSection {
    let header: String?
    let footer: String?
    let cells: [SettingsCell]
    
    static func getSettings() -> [SettingsSection] {
        let settings = [
            SettingsSection(
                header: "First Section",
                footer: nil,
                cells: []),
            SettingsSection(
                header: "Second Header",
                footer: "Second Footer",
                cells: [])
        ]
        
        return settings
    }
}

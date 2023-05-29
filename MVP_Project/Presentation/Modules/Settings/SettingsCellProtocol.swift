//
//  SettingsCellProtocol.swift
//  MVP_Project
//
//  Created by Aleksei on 29.05.2023.
//

import UIKit

protocol SettingCellProtocol: AnyObject {
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
                cells: [
                    SettingsCell(title: "Системный режим",
                                 cellType: CustomCell())]),
            SettingsSection(
                header: "Second Header",
                footer: "Second Footer",
                cells: [
                    SettingsCell(title: "Ячейка второй секции",
                                     cellType: CustomCell())
                ])
        ]
        
        return settings
    }
}

struct SettingsCell {
    let title: String?
//    let action: Selector
    let cellType: SettingCellProtocol
}

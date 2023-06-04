//
//  SwitchCellBuilder.swift
//  MVP_Project
//
//  Created by Aleksei on 02.06.2023.
//

import UIKit

final class SwitchCellBuilder {
    
}

extension SwitchCellBuilder: SettingsCell {
    var cellID: String {
        "CustomCell"
    }
    
    var height: CGFloat {
        44
    }
    
    func register(for tableView: UITableView) {
        tableView.register(SwitchCell.self, forCellReuseIdentifier: cellID)
        print("регистрация")
    }
    
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SwitchCell else { return UITableViewCell() }
        
        return cell
    }
}

//
//  CustomCell.swift
//  MVP_Project
//
//  Created by Aleksei on 29.05.2023.
//

import UIKit

final class CustomCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell: SettingCellProtocol {
    var cellID: String {
        "CustomCell"
    }
    
    var height: CGFloat {
        44
    }
    
    func register(for tableView: UITableView) {
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellID)
        print("регистрация")
    }
    
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        return cell
    }
}

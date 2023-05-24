//
//  ComicsDataSource.swift
//  MVP_Project
//
//  Created by Aleksei on 23.05.2023.
//

import UIKit

protocol ComicsDataSource: UITableViewDataSource {
    var comics: [Comic] { get set}
}

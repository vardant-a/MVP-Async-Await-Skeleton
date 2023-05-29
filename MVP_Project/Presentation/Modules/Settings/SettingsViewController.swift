//
//  SettingsViewController.swift
//  MVP_Project
//
//  Created by Aleksei on 29.05.2023.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {}

final class SettingsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: SettingsPresenterProtocol
    
    private var settings: [SettingsSection] = [] {
        didSet {
            settings.forEach { section in
                for cell in section.cells {
                    cell.cellType.register(for: settingsTableView)
                }
            }
        }
    }
    
    // MARK: - Private lazy Properties
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .insetGrouped)
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        
        
        return tableView
    }()
    
    // MARK: - Init
    
    init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = SettingsSection.getSettings()
        view.addSubviews(settingsTableView)
        setupLayout()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

    // MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1, 2:
            return settings[section].header
        default:
            return settings[0].header
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 1, 2:
            return settings[section].footer
        default:
            return settings[0].footer
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settings[indexPath.section].cells[indexPath.row]

        return cell.cellType.dequeue(for: tableView, at: indexPath)
    }
}

    // MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return settings[indexPath.section].cells[indexPath.row].cellType.height
    }
}

    // MARK: - SettingsViewController + SettingsViewProtocol

extension SettingsViewController: SettingsViewProtocol {
}

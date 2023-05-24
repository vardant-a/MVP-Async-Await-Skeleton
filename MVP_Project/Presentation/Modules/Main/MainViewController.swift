//
//  MainViewController.swift
//  MVP_Project
//
//  Created by Aleksei on 16.05.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showContent(models: [Comic])
}

final class MainViewController: UIViewController{
    
    // MARK: - Private Properties
    
    private var presenter: MainViewPresenterProtocol
    
    private var models: [Comic]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private lazy Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = 75
        tableView.register(ComicTableViewCell.self,
                           forCellReuseIdentifier: ComicTableViewCell.cellID)
        
        return tableView
    }()
    
    // MARK: - Init
    
    init(presenter: MainViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubviews(tableView)
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavController()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

    // MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = models?[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ComicTableViewCell.cellID,
            for: indexPath) as? ComicTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(item)
        
        return cell
    }
}

    // MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic = models?[indexPath.row]
        
        print(comic?.title ?? "nil")
    }
}

    // MARK: - Settings UINavigationController

private extension MainViewController {
    func setupNavController() {
        let fetchButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(tuppedNavAddButton))
        navigationItem.rightBarButtonItem = fetchButton
    }
    
    @objc func tuppedNavAddButton() {
        presenter.getComics()
    }
}

    // MARK: - MainViewController + MainViewPresenter

extension MainViewController: MainViewProtocol {
    func showContent(models: [Comic]) {
        self.models = models
    }
}

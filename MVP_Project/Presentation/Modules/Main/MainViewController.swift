//
//  MainViewController.swift
//  MVP_Project
//
//  Created by Aleksei on 16.05.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func changeStatusLoading(_ status: Bool)
    func showAlert(_ message: String)
    
    func showContent(models: [Comic])
    func refreshContent(newModels: [Comic])
}

final class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    
    private var loading = true
    
    // MARK: - Private Properties
    
    private var presenter: MainViewPresenterProtocol
    
    private var models: [Comic] = []
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Private lazy Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        tableView.backgroundColor = .clear
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
        tableView.register(SkeletonCell.self,
                           forCellReuseIdentifier: SkeletonCell.cellID)
        tableView.register(ComicCell.self,
                           forCellReuseIdentifier: ComicCell.cellID)
        
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
        view.backgroundColor = .lightGray
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
        if loading {
            return 10
        } else {
            return models.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loading {
            guard let skeletonCell = tableView.dequeueReusableCell(
                withIdentifier: SkeletonCell.cellID,
                for: indexPath) as? SkeletonCell else {
                return UITableViewCell()
            }
            
            return skeletonCell
        } else {
            let item = models[indexPath.row]
            guard let contentCell = tableView.dequeueReusableCell(
                withIdentifier: ComicCell.cellID,
                for: indexPath) as? ComicCell else {
                return UITableViewCell()
            }
            
            contentCell.configureCell(item)
            
            return contentCell
        }
    }
}

    // MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let offset = scrollView.contentOffset
            let bounds = scrollView.bounds
            let size = scrollView.contentSize
            let inset = scrollView.contentInset
            let sizeY = offset.y + bounds.size.height - inset.bottom
            let height = size.height

            let reloadDistance: CGFloat = 20
            if sizeY > height + reloadDistance {
                presenter.getContent(true)
            }
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
        presenter.getContent(true)
    }
    
    @objc func refreshTableView() {
        tableView.refreshControl?.beginRefreshing()
        presenter.getContent(false)
    }
}

    // MARK: - MainViewController + MainViewPresenter

extension MainViewController: MainViewProtocol {
    func showAlert(_ message: String) {
        let alertController = UIAlertController(
            title: nil, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Repeat loading", style: .default) { [weak self] _ in
            self?.presenter.getContent(true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func showContent(models: [Comic]) {
        loading = false
        if models.isEmpty {
            self.models = models
        } else {
            self.models.append(contentsOf: models)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func refreshContent(newModels: [Comic]) {
        self.models = newModels
        loading = false
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func changeStatusLoading(_ status: Bool) {
        loading = status
    }
}

//
//  MainViewController.swift
//  MVP_Project
//
//  Created by Aleksei on 16.05.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
}

final class MainViewController: UIViewController {
    
    private let presenter: MainViewPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: MainViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

    // MARK: - MainViewController + MainViewProtocol

extension MainViewController: MainViewProtocol {
}

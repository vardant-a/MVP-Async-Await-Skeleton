//
//  MainPresenter.swift
//  MVP_Project
//
//  Created by Aleksei on 16.05.2023.
//

import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    func injectView(with view: MainViewProtocol)
    
    func showMessage()
}

final class MainPresenter: MainViewPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    
    init() {}
    
    func injectView(with view: MainViewProtocol) {
        if self.view == nil { self.view = view }
    }
    
    func showMessage() {
        view?.showMessage(text: <#T##String#>)
    }
}

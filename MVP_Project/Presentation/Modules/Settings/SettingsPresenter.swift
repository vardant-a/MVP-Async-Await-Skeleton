//
//  SettingsPresenter.swift
//  MVP_Project
//
//  Created by Aleksei on 29.05.2023.
//

import UIKit

protocol SettingsPresenterProtocol: AnyObject {
    
    func injectView(_ view: SettingsViewProtocol)
}

final class SettingsPresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsViewProtocol?
    
    // MARK: - Init
    
    init() {}
    
    func injectView(_ view: SettingsViewProtocol) {
        if self.view == nil { self.view = view}
    }
}

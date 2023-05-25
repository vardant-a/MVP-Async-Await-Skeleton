//
//  MainPresenter.swift
//  MVP_Project
//
//  Created by Aleksei on 16.05.2023.
//

import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    init(networkManager: NetworkService)
    func injectView(_ view: MainViewProtocol)
    
    func getContent(_ newData: Bool)
}

final class MainPresenter: MainViewPresenterProtocol {
    
    // MARK: - Private Properties
    
    private let networkManager: NetworkService
    
    private weak var view: MainViewProtocol?
    
    // MARK: - Init
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public Methods
    
    func injectView(_ view: MainViewProtocol) {
        if self.view == nil { self.view = view}
    }
    
    func getContent(_ newData: Bool) {
        view?.changeStatusLoading(true)
        Task {
            do {
                guard let comicData: ComicDataWrapper = try await networkManager
                    .fetch() else { return }
                guard let comics = comicData.data?.results else { return }
                if newData {
                    view?.showContent(models: comics)
                } else {
                    view?.refreshContent(newModels: comics)
                }
            } catch {
                view?.showAlert(error.localizedDescription)
            }
        }
    }
}

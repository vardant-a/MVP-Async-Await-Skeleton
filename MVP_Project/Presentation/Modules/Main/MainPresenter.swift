//
//  MainPresenter.swift
//  MVP_Project
//
//  Created by Aleksei on 16.05.2023.
//

import UIKit

import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    init(networkManager: NetworkService)
    func injectView(_ view: MainViewProtocol)
    
    func getComics()
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
    
    func getComics() {
        Task {
            do {
                guard let comicData: ComicDataWrapper = try await networkManager
                    .fetch() else { return }
                guard let comics = comicData.data?.results else { return }
                view?.showContent(models: comics)
            } catch {
                print(error)
            }
        }
    }
}

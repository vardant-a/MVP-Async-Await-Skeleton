//
//  MainTabBarController.swift
//  MVP_Project
//
//  Created by Aleksei on 29.05.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: - Private Methods
    
    private func setupTabBar() {
        let mainVC = createTabBarItem(
            buildMainModule(),
            title: "Main",
            image: UIImage(systemName: "1.circle"),
            selectedImage: UIImage(systemName: "1.circle.fill"))
        
        let settingsVC = createTabBarItem(
            buildSettingsModule(),
            title: "Settings",
            image: UIImage(systemName: "2.circle"),
            selectedImage: UIImage(systemName: "2.circle.fill"))
        
        viewControllers = [mainVC, settingsVC]
        
        setupStyleTabBar()
    }
    
    private func buildMainModule() -> UIViewController {
        let presenter = MainPresenter(
            networkManager: NetworkManager())
        let view = MainViewController(presenter: presenter)
        presenter.injectView(view)
        
        return view
    }
    
    private func buildSettingsModule() -> UIViewController {
        let presenter = SettingsPresenter()
        let view = SettingsViewController(presenter: presenter)
        presenter.injectView(view)

        return view
    }
}

    // MARK: - Create UINavigationController + UIViewController

private extension MainTabBarController {
    func createTabBarItem(_ viewController: UIViewController, title: String,
        image: UIImage?, selectedImage: UIImage?) -> UINavigationController {
        guard let image = image, let selectedImage = selectedImage else {
            return UINavigationController()
        }
        
        let readyController = MainNavigationController(rootViewController: viewController)
        viewController.title = title
        readyController.tabBarItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: selectedImage)
        
        return readyController
    }
}

    // MARK: - Settings UITabBarItem Animation

extension MainTabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItem = item.value(forKey: "view") as? UIView else { return }
        let timeInterval: TimeInterval = 0.15
        let settingsAnimation = UIViewPropertyAnimator(
            duration: timeInterval,
            dampingRatio: 0.5) {
                barItem.transform = CGAffineTransform
                    .identity.scaledBy(x: 0.5, y: 0.5)
            }
        
        settingsAnimation.addAnimations(
            { barItem.transform = .identity },
            delayFactor: CGFloat(timeInterval))
        settingsAnimation.startAnimation()
    }
}

    // MARK: - Settings UITabBarController Style

private extension MainTabBarController {
    func setupStyleTabBar() {
        let tabBarAppearance = UITabBar.appearance()
        
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.unselectedItemTintColor = .lightGray
        tabBarAppearance.tintColor = .systemBlue
//        tabBarAppearance.barTintColor = .lightGray
    }
}


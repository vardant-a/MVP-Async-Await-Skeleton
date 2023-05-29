//
//  MainNavigationController.swift
//  MVP_Project
//
//  Created by Aleksei on 29.05.2023.
//

import UIKit

final class MainNavigationController: UINavigationController {
    
    // MARK: - Settings StatusBarStyle

    private var osTheme: UIUserInterfaceStyle {
        return UIScreen.main.traitCollection.userInterfaceStyle
    }
    
    override internal var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(
            rawValue: (
                topViewController?.preferredStatusBarStyle)?.rawValue ?? .max
        ) ?? .default
    }
    
    // MARK: - Public override Methods
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupStyleNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Settings Style NavigationBar
    
    private func setupStyleNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .lightGray
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        UINavigationBar.appearance().tintColor = .systemBlue
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}


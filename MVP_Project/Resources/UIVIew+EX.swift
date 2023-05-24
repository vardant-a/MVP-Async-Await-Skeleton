//
//  UIVIew+EX.swift
//  MVP_Project
//
//  Created by Aleksei on 23.05.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}

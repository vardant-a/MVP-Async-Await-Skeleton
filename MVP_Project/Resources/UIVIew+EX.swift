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
    
    func addGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        
        // Определите цвета градиента
        let startColor = UIColor.lightGray.cgColor
        let endColor = UIColor.darkGray.cgColor
        gradientLayer.colors = [startColor, endColor]
        
        // Определите точки начала и конца градиента
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        // Создайте анимацию градиента
        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.fromValue = [startColor, endColor]
        gradientAnimation.toValue = [endColor, startColor]
        gradientAnimation.duration = 0.7 // Длительность анимации (в секундах)
        gradientAnimation.autoreverses = true // Повтор анимации в обратном порядке
        gradientAnimation.repeatCount = Float.infinity // Бесконечное повторение анимации
        
        // Добавляем анимацию на градиентный слой
        gradientLayer.add(gradientAnimation, forKey: "gradientAnimation")
        
        // Добавьте градиентный слой в gradientView
        layer.addSublayer(gradientLayer)
    }
}

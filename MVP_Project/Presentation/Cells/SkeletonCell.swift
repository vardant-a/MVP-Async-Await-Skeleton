//
//  SkeletonCell.swift
//  MVP_Project
//
//  Created by Aleksei on 25.05.2023.
//

import UIKit

final class SkeletonCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let cellID = "SkeletonCell"
    
    // MARK: - Private Properties
    
    private let titleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let comicIdView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubviews(comicIdView, titleView)
        setupLayout()
    }
    
    // MARK: - Life Cycles Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.addGradientLayer()
        comicIdView.addGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupTitleLabelLayout()
        setupComicIdLabelLayout()
    }
    
    private func setupComicIdLabelLayout() {
        NSLayoutConstraint.activate([
            comicIdView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.horizontalOffset),
            comicIdView.trailingAnchor.constraint(
                equalTo: contentView.centerXAnchor,
                constant: -LocalConstants.horizontalOffset),
            comicIdView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -LocalConstants.verticalOffset),
            comicIdView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    private func setupTitleLabelLayout() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: LocalConstants.verticalOffset),
            titleView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.horizontalOffset),
            titleView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -LocalConstants.horizontalOffset),
            titleView.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
    
    // MARK: - Local Constants
    
    private enum LocalConstants {
        static let verticalOffset: CGFloat = 10
        static let horizontalOffset: CGFloat = 16
        static let horizontalSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 4
    }
}

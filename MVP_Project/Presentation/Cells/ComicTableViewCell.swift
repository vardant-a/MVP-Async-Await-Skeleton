//
//  ComicTableViewCell.swift
//  MVP_Project
//
//  Created by Aleksei on 23.05.2023.
//

import UIKit

final class ComicTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let cellID = "ComicTableViewCell"
    
    // MARK: - Private properties
    
    private var comicData: Comic? {
        didSet {
            guard let model = comicData else { return }
            DispatchQueue.main.async {
                self.titleLabel.text = model.title
                self.comicIdLabel.text = String(describing: model.id ?? 1)
                print("1")
            }
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    private var comicIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 11)
      
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        contentView.addSubviews(titleLabel, comicIdLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicData = nil
    }
    
    // MARK: - Public Methods
    
    func configureCell(_ comic: Comic?) {
        self.comicData = comic
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupTitleLabelLayout()
        setupComicIdLabelLayout()
    }
    
    private func setupComicIdLabelLayout() {
        NSLayoutConstraint.activate([
            comicIdLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.horizontalOffset),
            comicIdLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -LocalConstants.horizontalOffset),
            comicIdLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -LocalConstants.verticalOffset),
        ])
    }
    
    private func setupTitleLabelLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: LocalConstants.verticalOffset),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.horizontalOffset),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -LocalConstants.horizontalOffset)
        ])
    }
    
    // MARK: - Local Constants
    
    private enum LocalConstants {
        static let verticalOffset: CGFloat = 10
        static let horizontalOffset: CGFloat = 16
        static let horizontalSpacing: CGFloat = 8
    }
}

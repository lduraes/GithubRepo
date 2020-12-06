//
//  RepositoryTableViewCell.swift
//  GithubRepo
//
//  Created by Luiz Durães on 15/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    // MARK: - Constants
    private let ownerLabelfontSize: CGFloat = 15
    private let nameLabelfontSize: CGFloat = 15
    private let descriptionLabelfontSize: CGFloat = 13
    private let padding: CGFloat = 10

    // MARK: - Properties
    private var viewModel: RepositoryTableViewCellViewModel?
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: ownerLabelfontSize)
        label.textAlignment = .left
        label.frame.size = label.intrinsicContentSize
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping

        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: nameLabelfontSize)
        label.textAlignment = .left
        label.frame.size = label.intrinsicContentSize
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: descriptionLabelfontSize)
        label.textAlignment = .left
        label.frame.size = label.intrinsicContentSize
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping

        return label
    }()
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impviewModelted")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Public methods
    func configure(viewModel: RepositoryTableViewCellViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        guard let viewModel = self.viewModel else { return }
        contentView.backgroundColor = viewModel.getBackgroundColor()
        
        addOwnerLabel()
        addNameLabel()
        addDescriptionLabel()
    }
    
    private func addOwnerLabel() {
        guard let viewModel = self.viewModel else { return }
        ownerLabel.text = viewModel.model.owner.login
        addSubview(ownerLabel)
        
        NSLayoutConstraint.activate([
            ownerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            ownerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            ownerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
    
    private func addNameLabel() {
        guard let viewModel = self.viewModel else { return }
        nameLabel.text = viewModel.model.name
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }

    private func addDescriptionLabel() {
        guard let viewModel = self.viewModel else { return }
        descriptionLabel.text = viewModel.model.description
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}

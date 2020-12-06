//
//  ListRepositoryViewController.swift
//  GithubRepo
//
//  Created by Luiz Durães on 15/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import UIKit

class ListRepositoryViewController: UIViewController {
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))

        return tableView
    }()
    
    private lazy var viewModel: ListRepositoryViewModel = {
        let viewModel = ListRepositoryViewModel(delegate: self, provider: RepositoryProvider())
        
        return viewModel
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView .isHidden = false
        
        return activityIndicatorView
    }()
    
    private var dataSource = [Repository]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .clear : .white
        title = AppConfig.Title.repositoryList.rawValue
        
        addTableView()
        addActivityIndicatorView()
    }

    private func addTableView() {
        view.addSubview(tableView)
        let margins = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    private func addActivityIndicatorView() {
        view.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupViewModel() {
        viewModel.fetchRepositoryList()
    }

    private func stopAndHideActivityIndicatorView() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - ListRepositoryDelegate methods
extension ListRepositoryViewController: ListRepositoryDelegate {
    func repositoryListWillLoad() {
        activityIndicatorView.startAnimating()
    }
    
    func repositoryListDidLoad(items: [Repository]) {
        dataSource = items
        stopAndHideActivityIndicatorView()
        tableView.isHidden = false
    }

    func repositoryListDidFailLoad(error: Error) {
        print("[ERR] repositoryListDidFailLoad >> \(error.localizedDescription)")
        showAlert(title: NSLocalizedString("alert_title_error", comment: ""), message: error.localizedDescription)
        stopAndHideActivityIndicatorView()
    }
}

// MARK: - UITableViewDataSource methods
extension ListRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self), for: indexPath) as? RepositoryTableViewCell {
            let model = dataSource[indexPath.row]
            let viewModel = RepositoryTableViewCellViewModel(model: model)
            cell.configure(viewModel: viewModel)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate methods
extension ListRepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

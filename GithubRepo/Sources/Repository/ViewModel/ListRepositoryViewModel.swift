//
//  ListRepositoryViewModel.swift
//  GithubRepo
//
//  Created by Luiz Durães on 17/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

protocol ListRepositoryDelegate: AnyObject {
    func repositoryListWillLoad()
    func repositoryListDidLoad(items: [Repository])
    func repositoryListDidFailLoad(error: Error)
}

final class ListRepositoryViewModel {
    // MARK: - Properties
    private weak var delegate: ListRepositoryDelegate?
    private var provider: RepositoryProviderDelegate
    
    // MARK: - Initializers
    init(delegate: ListRepositoryDelegate?, provider: RepositoryProviderDelegate) {
        self.delegate = delegate
        self.provider = provider
    }
    
    // MARK: - Public methods
    func fetchRepositoryList() {
        delegate?.repositoryListWillLoad()
        
        provider.fetchRepositoryList { result in
            switch result {
            case .success(let repositories):
                self.delegate?.repositoryListDidLoad(items: repositories)
            case .failure(let error):
                self.delegate?.repositoryListDidFailLoad(error: error)
            }
        }
    }
}

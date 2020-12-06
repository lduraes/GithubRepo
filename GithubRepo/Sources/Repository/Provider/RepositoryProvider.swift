//
//  RepositoryProvider.swift
//  GithubRepo
//
//  Created by Luiz Durães on 17/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

protocol RepositoryProviderDelegate: AnyObject {
    func fetchRepositoryList(completionhandler: @escaping (Result<[Repository], HttpProviderError>) -> Void)
}

final class RepositoryProvider: HttpProvider {
    
}

// MARK: - RepositoryProviderDelegate methods
extension HttpProvider: RepositoryProviderDelegate {
    func fetchRepositoryList(completionhandler: @escaping (Result<[Repository], HttpProviderError>) -> Void) {
        fetch(endpoint: AppConfig.repositoryListEndpoint) { result in
           completionhandler(result)
        }
    }
}

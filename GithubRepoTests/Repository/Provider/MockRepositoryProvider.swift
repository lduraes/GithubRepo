//
//  MockRepositoryProviderTest.swift
//  GithubRepoTests
//
//  Created by Luiz Duraes on 25/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

@testable import GithubRepo

final class MockRepositoryProvider: RepositoryProviderDelegate {
    // MARK: - Properties
    private let mockRepository = MockRepository()
    var simulateError = false
    
    // MARK: - Public methods
    func fetchRepositoryList(completionhandler: @escaping (Result<[Repository], HttpProviderError>) -> Void) {
        if simulateError {
            completionhandler(.failure(.unavailable))
        } else {
            do {
                completionhandler(.success(try mockRepository.getMock()))
            } catch {
                completionhandler(.failure(.decoding))
            }
        }
    }
}

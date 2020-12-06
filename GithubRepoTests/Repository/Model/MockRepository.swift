//
//  MockRepository.swift
//  GithubRepoTests
//
//  Created by Luiz Duraes on 25/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
@testable import GithubRepo

class MockRepository: Decodable {
    // MARK: - Public methods
    func getMock() throws -> [Repository] {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "mock-repositories", ofType: "json") else { fatalError("mock-repositories.json not found") }
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .alwaysMapped)
        let mockedRepositories = try JSONDecoder().decode([Repository].self, from: data)
        
        return mockedRepositories
    }
}

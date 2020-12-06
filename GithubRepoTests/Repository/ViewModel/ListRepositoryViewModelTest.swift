//
//  ListRepositoryViewModelTest.swift
//  GithubRepoTests
//
//  Created by Luiz Durães on 24/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import XCTest
@testable import GithubRepo

class ListRepositoryViewModelTest: XCTestCase {
    // MARK: - Properties
    private weak var delegate: MockListRepositoryViewModel?
    private var provider: MockRepositoryProvider!
    private var viewModel: ListRepositoryViewModel!
    
    override func setUp() {
        super.setUp()
        delegate = MockListRepositoryViewModel()
        provider = MockRepositoryProvider()
        viewModel = ListRepositoryViewModel(delegate: delegate, provider: provider)
    }
    
    override func tearDown() {
        super.tearDown()
        delegate = nil
        provider = nil
        viewModel = nil
    }
    
    func testShouldFetchRepositoryListSuccessfully() {
        // given
        let successExpectation = XCTestExpectation()
        
        // when
        viewModel.fetchRepositoryList()
        
        // then
        delegate?.validateShouldFetchRepositoryListSuccessfully(expectation: successExpectation)
    }
    
    func testShouldFailFetchRepositoryList() {
        // given
        let failExpectation = XCTestExpectation()
        
        // when
        provider.simulateError = true
        viewModel.fetchRepositoryList()
        
        // then
        delegate?.validateShouldFailFetchRepositoryList(expectation: failExpectation)
    }
}

private class MockListRepositoryViewModel {
    // MARK: - Properties
    private var repositoryListWillLoadCalled = false
    private var repositoryListDidLoadCalled = false
    private var repositoryListDidFailLoadCalled  = false
    private var repositories = [Repository]()

    // MARK: - Fileprivate methods
    fileprivate func validateShouldFetchRepositoryListSuccessfully(expectation: XCTestExpectation) {
        XCTAssertTrue(repositoryListWillLoadCalled)
        XCTAssertTrue(repositoryListDidLoadCalled)
        XCTAssertFalse(repositoryListDidFailLoadCalled)
        XCTAssertFalse(repositories.isEmpty)
        expectation.fulfill()
    }

    fileprivate func validateShouldFailFetchRepositoryList(expectation: XCTestExpectation) {
        XCTAssertTrue(repositoryListWillLoadCalled)
        XCTAssertFalse(repositoryListDidLoadCalled)
        XCTAssertTrue(repositoryListDidFailLoadCalled)
        XCTAssertTrue(repositories.isEmpty)
        expectation.fulfill()
    }
}

// MARK: - ListRepositoryDelegate methods
extension MockListRepositoryViewModel: ListRepositoryDelegate {
    func repositoryListWillLoad() {
        repositoryListWillLoadCalled = true
    }
    
    func repositoryListDidLoad(items: [Repository]) {
        repositoryListDidLoadCalled = true
        repositories = items
    }
    
    func repositoryListDidFailLoad(error: Error) {
        repositoryListDidFailLoadCalled = true
    }
}

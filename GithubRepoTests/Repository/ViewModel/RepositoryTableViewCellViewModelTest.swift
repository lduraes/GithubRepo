//
//  RepositoryTableViewCellViewModelTest.swift
//  GithubRepoTests
//
//  Created by Luiz Durães on 26/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import XCTest
@testable import GithubRepo

class RepositoryTableViewCellViewModelTest: XCTestCase {
    // MARK: - Properties
    private var mockRepository: MockRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
    }
    
    override func tearDown() {
        mockRepository = nil
        super.tearDown()
    }
    
    func testShouldGetWhiteBackgroundColorSuccessfully() {
        // given
        let viewModelLightGreen = RepositoryTableViewCellViewModel(model: getMockedRepostory(index: 0))
        
        // when
        let backgroundColor = viewModelLightGreen.getBackgroundColor()
        
        // then
        XCTAssertEqual(backgroundColor, .green)
    }
    
    func testShouldFailFetchRepositoryList() {
        // given
        let viewModelWhite = RepositoryTableViewCellViewModel(model: getMockedRepostory(index: 1))
        
        // when
        let backgroundColor = viewModelWhite.getBackgroundColor()
        
        // then
        XCTAssertEqual(backgroundColor, .clear)
    }
    
    private func getMockedRepostory(index: Int) -> Repository {
        do {
            return try mockRepository.getMock()[index]
        } catch {
            print("Error retrieving mocked repository object index")
        }
        
        return Repository.init(name: "",
                               description: "",
                               owner: Owner(login: ""),
                               fork: false)
    }
}

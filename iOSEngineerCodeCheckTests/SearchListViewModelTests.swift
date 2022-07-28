//
//  SearchListViewModelTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Toshiyana on 2022/07/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import XCTest

class SearchListViewModelTests: XCTestCase {
    var mockGitHubAPI: MockGitHubAPI!
    var sut: SearchListViewModel!

    override func setUpWithError() throws {
        mockGitHubAPI = MockGitHubAPI()
        sut = SearchListViewModel(githubAPI: mockGitHubAPI)
    }

    override func tearDownWithError() throws {
        mockGitHubAPI = nil
        sut = nil
    }

    func testSearchListViewModel_WhenSearchButtonClicked_Success() {
        sut.inputs.searchBarText.accept(String.mock)
        sut.inputs.searchButtonClicked.accept(())
        XCTAssertEqual(sut.outputs.repoItems.value, MockData.getRepoItems(), "期待する検索結果が返ってくること")
    }
    
    func testSearchListViewModel_WhenSearchButtonClicked_Failure() {
        mockGitHubAPI.shouldReturnError = true
        sut.inputs.searchBarText.accept(String.mock)
        sut.inputs.searchButtonClicked.accept(())
        // TODO: Error発生を確認（Assertの方法が分からなかった）
    }
}

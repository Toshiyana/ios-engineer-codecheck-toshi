//
//  MockGitHubAPI.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Toshiyana on 2022/07/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import Foundation
import RxSwift

class MockGitHubAPI: GitHubAPIProtocol {

    var isSearchRepositoryMethodCalled: Bool = false
    var shouldReturnError: Bool = false

    func searchRepository(keyValue: [String : Any]) throws -> Observable<GitHubResponse> {
        isSearchRepositoryMethodCalled = true
        
        if shouldReturnError {
            throw APIError.unexpectedServerError
        } else {
            return MockData.getObservableGitHubResponse()
        }
    }
}

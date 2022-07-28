//
//  MockData.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Toshiyana on 2022/07/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import Foundation
import RxSwift

class MockData {
    static func getGitHubResponse() -> GitHubResponse {
        let owner: Owner = Owner(id: .mock, avatarUrl: .mock)
        let repoItems: [RepoItem] = [
            RepoItem(id: .mock, fullName: .mock, owner: owner,
                     stargazersCount: .mock, watchersCount: .mock, language: .mock,
                     forksCount: .mock, openIssuesCount: .mock, topics: [.mock])
        ]
        return GitHubResponse(items: repoItems)
    }
    static func getObservableGitHubResponse() -> Observable<GitHubResponse> {
        return Observable.just(getGitHubResponse())
    }
    
    static func getRepoItems() -> [RepoItem] {
        return getGitHubResponse().items
    }
}
extension String {
    static let mock = "mock"
}
extension URL {
    static let mock = URL(string: "http://www.dummy.com/")!
}
extension Int {
    static let mock = 1
}
extension Double {
    static let mock = 1.0
}

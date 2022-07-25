//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxSwift
import Moya

final class GitHubAPI {
    private static let provider = MoyaProvider<GitHubTarget>()
    
    static func searchRepository(keyValue: [String: Any]) throws -> Observable<GitHubResponse> {
        return provider.rx.request(
            .searchRepository(keyValue: keyValue))
            .map { response in
                try APIResponseStatusCodeHandler.handleStatusCode(response)
                return try JSONDecoder().decode(GitHubResponse.self, from: response.data)
            }
            .asObservable()
    }
}

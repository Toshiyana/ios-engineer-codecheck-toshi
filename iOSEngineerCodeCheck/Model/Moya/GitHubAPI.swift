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
    private let provider = MoyaProvider<GitHubTarget>()
    
    func searchRepository(keyValue: [String: Any]) throws -> Single<GitHubResponse> {
        return Single<GitHubResponse>.create { [provider] observer in
            provider.request(
                .searchRepository(keyValue: keyValue)) { [weak self] response in
                    guard let strongSelf = self else { return }
                    switch response {
                    case .success(let response):
                        observer(strongSelf.decodeToGitHubResponse(response: response))
                    case .failure:
                        observer(.failure(GitHubAPIError.responseError))
                    }
            }
            return Disposables.create()
        }
    }
    
    private func decodeToGitHubResponse(response: Response) -> Result<GitHubResponse, Error> {
        do {
            let decoder = JSONDecoder()
            let response = try response.filterSuccessfulStatusAndRedirectCodes()
            let gitHubResponse = try response.map(GitHubResponse.self, using: decoder)
            return .success(gitHubResponse)
        } catch {
            return .failure(GitHubAPIError.decodeError)
        }
    }
}

enum GitHubAPIError: Error {
    case decodeError
    case responseError
}

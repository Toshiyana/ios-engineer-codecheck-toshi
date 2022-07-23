//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import Moya

typealias CompletionHandler<T> = (Result<T, GitHubAPIError>) -> Void

final class GitHubAPI {
    static let shared = GitHubAPI()

    // providerでNetworkLoggerPlugin()を指定し、リクエストのログを表示
    private let provider = MoyaProvider<GitHubTarget>(plugins: [NetworkLoggerPlugin()])

    func searchRepository(keyValue: [String: Any], completion: @escaping CompletionHandler<GitHubResponse>) {
        provider.request(.searchRepository(keyValue: keyValue)) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                completion(strongSelf.decodeToGitHubResponse(response: response))
            case .failure:
                completion(.failure(.responseError))
            }
        }
    }

    private func decodeToGitHubResponse(response: Response) -> Result<GitHubResponse, GitHubAPIError> {
        do {
            let decoder = JSONDecoder()
            let response = try response.filterSuccessfulStatusAndRedirectCodes()
            let gitHubResponse = try response.map(GitHubResponse.self, using: decoder)
            return .success(gitHubResponse)
        } catch {
            return .failure(.decodeError)
        }
    }
}

enum GitHubAPIError: Error {
    case decodeError
    case responseError
}

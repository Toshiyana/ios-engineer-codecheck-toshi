//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import Moya

typealias CompletionHandler<T> = (Result<T, MoyaError>) -> Void

final class GitHubAPI {
    static let shared = GitHubAPI()

    private let provider = MoyaProvider<GitHubTarget>()

    func searchRepository(keyValue: [String: Any], completion: @escaping CompletionHandler<GitHubResponse>) {
        provider.request(.searchRepository(keyValue: keyValue)) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                completion(strongSelf.decodeToGitHubResponse(response: response))
            case .failure(let moyaError):
                completion(.failure(moyaError))
            }
        }
    }

    private func decodeToGitHubResponse(response: Response) -> Result<GitHubResponse, MoyaError> {
        do {
            let decoder = JSONDecoder()
            let response = try response.filterSuccessfulStatusAndRedirectCodes()
            let gitHubResponse = try response.map(GitHubResponse.self, using: decoder)
            return .success(gitHubResponse)
        } catch let error {
            guard let moyaError = error as? MoyaError else {
                fatalError("Downcast to MoyaError has an error.")
            }
            return .failure(moyaError)
        }
    }
}

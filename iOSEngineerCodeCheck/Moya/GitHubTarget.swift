//
//  GitHubTarget.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Moya

enum GitHubTarget {
    case searchRepository(keyValue: [String: Any])
}

extension GitHubTarget: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/") else {
            fatalError("baseURL has an error")
        }
        return url
    }

    var path: String {
        switch self {
        case .searchRepository:
            return "search/repositories"
        }
    }

    var method: Method {
        switch self {
        case .searchRepository:
            return .get
        }
    }

    var parameters: [String: Any] {
        // GitHubAPIのDefaultの設定
        var parameter = [
            "order": "desc",
            "per_page": 30,
            "page": 1
        ] as [String: Any]

        switch self {
        case .searchRepository(let keyValue):
            keyValue.forEach({ key, value in
                parameter[key] = value
            })
            return parameter
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .searchRepository:
            return Moya.URLEncoding.queryString
        }
    }

    var task: Task {
        switch self {
        case .searchRepository:
            print("DEBUG: parameters:: \(parameters)")
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

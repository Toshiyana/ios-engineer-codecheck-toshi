//
//  QueryShareManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final class QueryShareManager {
    private var queries: [String: Any] = [:]
    static let shared = QueryShareManager()

    func addQuery(key: String, value: String?) {
        if value != nil {
            QueryShareManager.shared.queries[key] = value
        } else {
            QueryShareManager.shared.queries[key] = nil
        }
    }

    func getQuery() -> [String: Any] {
        return QueryShareManager.shared.queries
    }
}

//
//  GitHubAPIProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubAPIProtocol {
    func searchRepository(keyValue: [String: Any]) throws -> Observable<GitHubResponse>
}

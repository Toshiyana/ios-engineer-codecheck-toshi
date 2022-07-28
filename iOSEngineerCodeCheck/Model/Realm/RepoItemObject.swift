//
//  RepoItemObject.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RealmSwift

final class RepoItemObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var ownerAvatarUrl: String = ""
    @objc dynamic var htmlUrl: String = ""
    @objc dynamic var stargazersCount: Int = 0
    @objc dynamic var watchersCount: Int = 0
    @objc dynamic var language: String = ""
    @objc dynamic var forksCount: Int = 0
    @objc dynamic var openIssuesCount: Int = 0

    convenience init (repoItem: RepoItem) {
        self.init()
        id = "\(repoItem.id)"
        fullName = repoItem.fullName
        ownerAvatarUrl = "\(repoItem.owner.avatarUrl)"
        htmlUrl = "\(repoItem.htmlUrl)"
        stargazersCount = repoItem.stargazersCount
        watchersCount = repoItem.watchersCount
        if let language = repoItem.language {
            self.language = language
        }
        forksCount = repoItem.forksCount
        openIssuesCount = repoItem.openIssuesCount
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}

//
//  RepoData.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GitHubResponse: Codable, Equatable {
    //    let totalCount: Int
    //    let incompleteResults: Bool
    let items: [RepoItem]
    enum CodingKeys: String, CodingKey {
        //        case totalCount = "total_count"
        //        case incompleteResults = "incomplete_results"
        case items
    }
}

struct RepoItem: Codable, Identifiable, Equatable {
    let id: Int
    //    let nodeId: String
    //    let name: String
    let fullName: String
    //    let `private`: Bool
    let owner: Owner
    let htmlUrl: URL
    //    let description: String
    //    let fork: Bool
    //    let url: URL
    //    let forksUrl: URL
    //    let keysUrl: URL
    //    let collaboratorsUrl: String
    //    let teamsUrl: URL
    //    let hooksUrl: URL
    //    let issueEventsUrl: URL
    //    let eventsUrl: URL
    //    let assigneesUrl: URL
    //    let branchesUrl: URL
    //    let tagsUrl: URL
    //    let blobsUrl: URL
    //    let gitTagsUrl: URL
    //    let gitRefsUrl: URL
    //    let treesUrl: URL
    //    let statusesUrl: URL
    //    let languagesUrl: URL
    //    let stargazersUrl: URL
    //    let contributorsUrl: URL
    //    let subscribersUrl: URL
    //    let subscriptionUrl: URL
    //    let commitsUrl: URL
    //    let gitCommitsUrl: URL
    //    let commentsUrl: URL
    //    let issueCommentUrl: URL
    //    let contentsUrl: URL
    //    let compareUrl: URL
    //    let mergesUrl: URL
    //    let archiveUrl: URL
    //    let downloadsUrl: URL
    //    let issuesUrl: URL
    //    let pullsUrl: URL
    //    let milestonesUrl: URL
    //    let notificationsUrl: URL
    //    let labelsUrl: URL
    //    let releasesUrl: URL
    //    let deploymentsUrl: URL
    //    let createdAt: String
    //    let updatedAt: String
    //    let pushedAt: String
    //    let gitUrl: String
    //    let sshUrl: String
    //    let cloneUrl: URL
    //    let svnUrl: URL
    //    let homepage: URL
    //    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    //    let hasIssues: Bool
    //    let hasProjects: Bool
    //    let hasDownloads: Bool
    //    let hasWiki: Bool
    //    let hasPages: Bool
    let forksCount: Int
    //    let mirrorUrl: String
    //    let archived: Bool
    //    let disabled: Bool
    let openIssuesCount: Int
    //    let license: License
    //    let allowForking: Bool
    //    let isTemplate: Bool
    //    let webCommitSignoffRequired: Bool
    //    let topics: [String]
    //    let visibility: String
    //    let forks: Int
    //    let openIssues: Int
    //    let watchers: Int
    //    let defaultBranch: String
    //    let score: Int

    enum CodingKeys: String, CodingKey {
        case id
        //        case nodeId = "node_id"
        //        case name
        case fullName = "full_name"
        //        case `private`
        case owner
        case htmlUrl = "html_url"
        //        case description
        //        case fork
        //        case url
        //        case forksUrl = "forks_url"
        //        case keysUrl = "keys_url"
        //        case collaboratorsUrl = "collaborators_url"
        //        case teamsUrl = "teams_url"
        //        case hooksUrl = "hooks_url"
        //        case issueEventsUrl = "issue_events_url"
        //        case eventsUrl = "events_url"
        //        case assigneesUrl = "assignees_url"
        //        case branchesUrl = "branches_url"
        //        case tagsUrl = "tags_url"
        //        case blobsUrl = "blobs_url"
        //        case gitTagsUrl = "git_tags_url"
        //        case gitRefsUrl = "git_refs_url"
        //        case treesUrl = "trees_url"
        //        case statusesUrl = "statuses_url"
        //        case languagesUrl = "languages_url"
        //        case stargazersUrl = "stargazers_url"
        //        case contributorsUrl = "contributors_url"
        //        case subscribersUrl = "subscribers_url"
        //        case subscriptionUrl = "subscription_url"
        //        case commitsUrl = "commits_url"
        //        case gitCommitsUrl = "git_commits_url"
        //        case commentsUrl = "comments_url"
        //        case issueCommentUrl = "issue_comment_url"
        //        case contentsUrl = "contents_url"
        //        case compareUrl = "compare_url"
        //        case mergesUrl = "merges_url"
        //        case archiveUrl = "archive_url"
        //        case downloadsUrl = "downloads_url"
        //        case issuesUrl = "issues_url"
        //        case pullsUrl = "pulls_url"
        //        case milestonesUrl = "milestones_url"
        //        case notificationsUrl = "notifications_url"
        //        case labelsUrl = "labels_url"
        //        case releasesUrl = "releases_url"
        //        case deploymentsUrl = "deployments_url"
        //        case createdAt = "created_at"
        //        case updatedAt = "updated_at"
        //        case pushedAt = "pushed_at"
        //        case gitUrl = "git_url"
        //        case sshUrl = "ssh_url"
        //        case cloneUrl = "clone_url"
        //        case svnUrl = "svn_url"
        //        case homepage
        //        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        //        case hasIssues = "has_issues"
        //        case hasProjects = "has_projects"
        //        case hasDownloads = "has_downloads"
        //        case hasWiki = "has_wiki"
        //        case hasPages = "has_pages"
        case forksCount = "forks_count"
        //        case mirrorUrl = "mirror_url"
        //        case archived
        //        case disabled
        case openIssuesCount = "open_issues_count"
        //        case license
        //        case allowForking = "allow_forking"
        //        case isTemplate = "is_template"
        //        case webCommitSignoffRequired = "web_commit_signoff_required"
        //        case topics
        //        case visibility
        //        case forks
        //        case openIssues
        //        case watchers
        //        case defaultBranch = "default_branch"
        //        case score
    }
}

struct Owner: Codable, Identifiable, Equatable {
    //    let login: String
    let id: Int
    //    let nodeId: String
    let avatarUrl: String
    //    let gravatarId: String
    //    let url: URL
    //    let htmlUrl: URL
    //    let followersUrl: URL
    //    let followingUrl: URL
    //    let gistsUrl: URL
    //    let starredUrl: URL
    //    let subscriptionsUrl: URL
    //    let organizationsUrl: URL
    //    let reposUrl: URL
    //    let eventsUrl: URL
    //    let receivedEventsUrl: URL
    //    let type: String
    //    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        //        case login
        case id
        //        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        //        case gravatarId = "gravatar_id"
        //        case url
        //        case htmlUrl = "html_url"
        //        case followersUrl = "followers_url"
        //        case followingUrl = "following_url"
        //        case gistsUrl = "gists_url"
        //        case starredUrl = "starred_url"
        //        case subscriptionsUrl = "subscriptions_url"
        //        case organizationsUrl = "organizations_url"
        //        case reposUrl = "repos_url"
        //        case eventsUrl = "events_url"
        //        case receivedEventsUrl = "received_events_url"
        //        case type
        //        case siteAdmin = "site_admin"
    }
}

struct License: Codable, Equatable {
    let key: String
    let name: String
    let spdxId: String
    let url: URL
    let nodeId: String
    enum CodingKeys: String, CodingKey {
        case key
        case name
        case spdxId = "spdx_id"
        case url
        case nodeId = "node_id"
    }
}

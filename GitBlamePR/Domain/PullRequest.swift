//
//  PullRequest.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct PullRequest: Decodable {
    var number: Int
    var htmlUrl: URL
    var title: String
    var body: String
    var user: PullRequestUser
    var mergedAt: Date
    var comments: Int
    var reviewComments: Int
    var commits: Int
    var additions: Int
    var deletions: Int
    var changedFiles: Int
    var conversationCount: Int {
        comments + reviewComments
    }
}

struct PullRequestUser: Decodable {
    var login: String
    var avatarUrl: URL
    var htmlUrl: URL
}

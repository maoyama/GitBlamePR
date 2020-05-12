//
//  PullRequest.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct PullRequest: Decodable {
    let number: Int
    let htmlUrl: URL
    let title: String
    let body: String
    let user: PullRequestUser
    let mergedAt: Date
    let comments: Int
    let reviewComments: Int
    let commits: Int
    let additions: Int
    let deletions: Int
    let changedFiles: Int
    var conversationCount: Int {
        comments + reviewComments
    }
}

struct PullRequestUser: Decodable {
    let login: String
    let avatarUrl: URL
    let htmlUrl: URL
}

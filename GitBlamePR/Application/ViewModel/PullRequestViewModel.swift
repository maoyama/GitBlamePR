//
//  PullRequestViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct PullRequestViewModel {
    var htmlURL: URL
    var number: String
    var title: String
    var body: String
    var user: String
    var userAvatarURL: URL
    var mergedAt: String
    var conversationCount: String
    var commitsCount: String
    var changedFiles: String
    var additionsCount: String
    var deletionsCount: String
}

extension PullRequestViewModel {
    init(from pr: PullRequest) {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .none

        htmlURL = pr.htmlUrl
        number = "#\(pr.number)"
        title = pr.title
        body = pr.body
        user = pr.user.login
        userAvatarURL = pr.user.avatarUrl
        mergedAt = f.string(from: pr.mergedAt)
        conversationCount = "\(pr.conversationCount)"
        commitsCount = "\(pr.commits)"
        changedFiles = "\(pr.changedFiles)"
        additionsCount = "+\(pr.additions)"
        deletionsCount = "-\(pr.deletions)"
    }
}

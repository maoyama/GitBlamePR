//
//  CommitViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct CommitViewModel {
    var hash: String
    var author: String
    var authorEmail: String
    var authorDate: String
    var committer: String
    var committerEmail: String
    var committerDate: String
    var titleLine: String
    var fullCommitMessage: String
}

extension CommitViewModel {
    init(from commit: Commit) {
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .long

        hash = commit.hash
        author = commit.author
        authorEmail = commit.authorEmail
        authorDate = f.string(from: commit.authorDate)
        committer = commit.committer
        committerEmail = commit.committerEmail
        committerDate = f.string(from: commit.committerDate)
        titleLine = commit.titleLine
        fullCommitMessage = commit.fullCommitMessage
    }
}

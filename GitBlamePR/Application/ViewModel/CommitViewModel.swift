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
    var titleLine: String
    var fullCommitMessage: String
    var html: URL?
}

extension CommitViewModel {
    init(from commit: Commit) {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .none

        hash = commit.hash
        author = commit.author
        authorEmail = commit.authorEmail
        authorDate = f.string(from: commit.authorDate)
        titleLine = commit.titleLine
        fullCommitMessage = commit.fullCommitMessage
        html = commit.html
    }
}

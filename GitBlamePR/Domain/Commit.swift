//
//  Commit.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct Commit {
    let hash: String
    let author: String
    let authorEmail: String
    let authorDate: Date
    let committer: String
    let committerEmail: String
    let committerDate: Date
    let titleLine: String
    let fullCommitMessage: String
    let repository: GitRepository?
    var html: URL? {
        return repository?.html.appendingPathComponent("commit").appendingPathComponent(hash)
    }
}

extension Commit {
    init(from show: GitShowCommand, command remote: GitRemoteCommand) throws {
        let output = try show.standardOutput()
        let l = output.components(separatedBy: show.separator)
        hash = l[show.placeholders.firstIndex(of: .commitHash)!]
        author = l[show.placeholders.firstIndex(of: .authorName)!]
        authorEmail = l[show.placeholders.firstIndex(of: .authorEmail)!]
        authorDate = ISO8601DateFormatter().date(
            from: l[show.placeholders.firstIndex(of: .authorDate)!]
        )!
        committer = l[show.placeholders.firstIndex(of: .committerName)!]
        committerEmail = l[show.placeholders.firstIndex(of: .committerEmail)!]
        committerDate = ISO8601DateFormatter().date(
            from: l[show.placeholders.firstIndex(of: .committerDate)!]
        )!
        titleLine = l[show.placeholders.firstIndex(of: .subject)!]
        fullCommitMessage = l[show.placeholders.firstIndex(of: .body)!]
        self.repository =  try? remote.output()
    }
}

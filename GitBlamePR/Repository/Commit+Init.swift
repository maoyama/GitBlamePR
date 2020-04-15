//
//  Commit+Init.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

extension Commit {
    init(from command: GitShowCommand) throws {
        let lines = try command.output().components(separatedBy: command.separator)
        guard lines.count > 8 else {
            throw CommandError.unknown
        }
        hash = lines[0]
        author = lines[1]
        authorEmail = lines[2]
        guard let authorDate = ISO8601DateFormatter().date(from: lines[3]) else {
            throw CommandError.unknown
        }
        self.authorDate = authorDate
        committer = lines[4]
        committerEmail = lines[5]
        guard let committerDate = ISO8601DateFormatter().date(from: lines[6]) else {
            throw CommandError.unknown
        }
        self.committerDate = committerDate
        titleLine = lines[7]
        fullCommitMessage = lines[8]
    }
}

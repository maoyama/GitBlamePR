//
//  Commit+Init.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

extension Commit {
    init?(from command: GitShowCommand) {
        guard let output = try? command.output() else { return nil }
        let lines = output.components(separatedBy: .newlines)
        guard lines.count > 8 else { return nil }
        hash = lines[0]
        author = lines[1]
        authorEmail = lines[2]
        guard let authorDate = ISO8601DateFormatter().date(from: lines[3]) else { return nil }
        self.authorDate = authorDate
        committer = lines[4]
        committerEmail = lines[5]
        guard let committerDate = ISO8601DateFormatter().date(from: lines[6]) else { return nil }
        self.committerDate = committerDate
        titleLine = lines[7]
        fullCommitMessage = lines[8]
    }
}

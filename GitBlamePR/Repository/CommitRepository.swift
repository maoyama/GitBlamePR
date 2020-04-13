//
//  CommitRepositiry.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct CommitRepositiry {
    func find(byCommitHash hash: String, directoryURL: URL) throws -> Commit {
        let command = GitShowCommand(commitHash: hash, directoryURL: directoryURL)
        return try Commit(from: command)
    }
}

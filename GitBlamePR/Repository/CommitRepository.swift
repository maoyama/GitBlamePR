//
//  CommitRepositiry.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct CommitRepositiry {
    func find(byCommitHash hash: String, path: FileFullPath) throws -> Commit {
        let show = GitShowCommand(commitHash: hash, directoryURL: path.directoryURL)
        let remote = GitRemoteCommand(directoryURL: path.directoryURL)
        return try Commit(from: show, command: remote)
    }
}

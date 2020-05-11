//
//  GitRemoteCommand.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/19.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct GitRemoteCommand: GitCommand {
    var arguments: [String] {
        ["remote", "-v"]
    }
    var directoryURL: URL

    func output() throws -> GitRepository {
        let outputStr = try standardOutput()
        guard let output = GitRepository(gitRemoteStandardOutput: outputStr) else {
            throw CommandError(description: "Standard output parse error.")
        }
        return output
    }
}

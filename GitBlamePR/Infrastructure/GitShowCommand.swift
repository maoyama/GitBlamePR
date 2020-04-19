//
//  GitShowCommand.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

// Placeholder are https://git-scm.com/docs/git-show#Documentation/git-show.txt-emnem
private enum GitShowCommandFormatPlaceholder: String {
    case commitHash = "%H"
    case authorName = "%aN"
    case authorEmail = "%aE"
    case authorDate = "%aI" //strict ISO 8601 format
    case committerName = "%cN"
    case committerEmail = "%cE"
    case committerDate = "%cI" //strict ISO 8601 format
    case subject = "%s"
    case body = "%b"
}

struct GitShowCommand: GitCommand {
    var commitHash: String
    var directoryURL: URL
    var arguments: [String] {
        let format = placeholders.map { (placeholder) -> String in
            return placeholder.rawValue + separator
        }.joined()
        return ["show", "--format=\(format)", commitHash]
    }
    private var separator: String {
        "{separator-44cd166895ac93832525f3f7eca6b7e1fef8fe3d}"
    }
    private var placeholders: [GitShowCommandFormatPlaceholder] {
        [.commitHash, .authorName, .authorEmail, .authorDate, .committerName, .committerEmail, .committerDate, .subject, .body]
    }

    func output() throws -> Commit {
        let output = try standardOutput()
        let l = output.components(separatedBy: separator)
        return Commit(
            hash: l[placeholders.firstIndex(of: .commitHash)!],
            author: l[placeholders.firstIndex(of: .authorName)!],
            authorEmail: l[placeholders.firstIndex(of: .authorEmail)!],
            authorDate: ISO8601DateFormatter().date(
                from: l[placeholders.firstIndex(of: .authorDate)!]
            )!,
            committer: l[placeholders.firstIndex(of: .committerName)!],
            committerEmail: l[placeholders.firstIndex(of: .committerEmail)!],
            committerDate: ISO8601DateFormatter().date(
                from: l[placeholders.firstIndex(of: .committerDate)!]
            )!,
            titleLine: l[placeholders.firstIndex(of: .subject)!],
            fullCommitMessage: l[placeholders.firstIndex(of: .body)!]
        )
    }
}

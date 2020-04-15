//
//  GitCommand.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

protocol GitCommand: Command {}
extension GitCommand {
    var executableURL: URL {
        URL(fileURLWithPath: "/usr/bin/git")
    }
}

struct GitShowCommand: GitCommand {
    let separator = "{separator-44cd166895ac93832525f3f7eca6b7e1fef8fe3d}"
    var formatPlaceHolders: [GitShowCommandFormatPlaceholder] = [.commitHash, .authorName, .authorEmail, .authorDate, .committerName, .committerEmail, .committerDate, .subject, .body]
    private (set) var commitHash: String
    private (set) var directoryURL: URL
    var arguments: [String] {
        let format = formatPlaceHolders.map { (placeholder) -> String in
            return placeholder.rawValue + separator
        }.joined()
        return ["show", "--format=\(format)", commitHash]
    }

    init(commitHash: String, directoryURL: URL) {
        self.commitHash = commitHash
        self.directoryURL = directoryURL
    }
}

// Placeholder are https://git-scm.com/docs/git-show#Documentation/git-show.txt-emnem
enum GitShowCommandFormatPlaceholder: String {
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

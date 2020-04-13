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
    private (set) var arguments: [String] = ["show", "--format=\"%H%n%an%n%aE%aI%n%cn%n%cE%cI%n%s%n%b%n\""]
    private (set) var directoryURL: URL

    init(commitHash: String, directoryURL: URL) {
        self.arguments.append(commitHash)
        self.directoryURL = directoryURL
    }
}

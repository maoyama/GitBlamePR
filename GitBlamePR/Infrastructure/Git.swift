//
//  Git.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

// TODO: Git => GitCommand

struct GitError: Error, LocalizedError {
    private var description: String
    var errorDescription: String? {
        return description
    }

    init(description: String) {
        self.description = description
    }
}

struct Git {
    static func remote(path: FileFullPath) throws -> String {
        return try Self.runGitProcess(
                executableURL: URL(fileURLWithPath: "/usr/bin/git"),
                arguments: ["remote", "-v"],
                currentDirectoryURL: path.directoryURL
        )
    }

    static func blamePR(path: FileFullPath) throws -> String {
        return try Self.runGitProcess(
            executableURL: URL(fileURLWithPath: "/usr/bin/perl"),
            arguments: [Bundle.main.resourcePath! + "/git-blame-pr.pl", path.trimmed],
            currentDirectoryURL: path.directoryURL
        )
    }

    static func show(path: FileFullPath, hash: String) throws -> String {
        return  try Self.runGitProcess(
            executableURL: URL(fileURLWithPath: "/usr/bin/git"),
            arguments: ["show", "--format=\"%H%n%an%n%ai%n%aE\"", "--date=rfc", hash],
            currentDirectoryURL: path.directoryURL
        )
    }

    static private func runGitProcess(executableURL: URL, arguments: [String], currentDirectoryURL: URL?) throws -> String {
        do {
            let out = try Process.run(executableURL: executableURL, arguments: arguments, currentDirectoryURL: currentDirectoryURL)
            return out
        } catch ProcessError.standardError(let description) {
            throw GitError(description: description)
        } catch let e {
            throw GitError(description: e.localizedDescription)
        }
    }
}

//
//  ApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/14.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

class ApplicationService: ObservableObject {
    var fullPath: String = "" {
        didSet {
            guard !fullPath.isEmpty else {
                viewModel = GitBlamePRViewModel()
                viewModel.recent = RecentViewModel(fullPaths: [
                    (value: "/Users/aoyama/Dropbox/GitBlamePR/README.md", id: UUID())
                ]) // TODO
                return
            }
            execute()
        }
    }
    @Published private(set) var viewModel = GitBlamePRViewModel(
        lines: [],
        recent: RecentViewModel(
            fullPaths: [
                (value: "/Users/aoyama/Dropbox/GitBlamePR/README.md", id: UUID())
            ]
        )
    )
    private var trimedFullPath: String {
        fullPath.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private var fullPathDirectoryURL: URL {
        URL(fileURLWithPath: trimedFullPath).deletingLastPathComponent()
    }

    private func execute() {
        var remoteOut = ""
        var blamePROut = ""
        do {
            remoteOut = try executeGitRemote()
            blamePROut = try executeGitBlamePR()
        } catch ProcessError.standardError(let description) {
            viewModel = GitBlamePRViewModel()
            viewModel.error = description
            return
        } catch let e {
            viewModel = GitBlamePRViewModel()
            viewModel.error = e.localizedDescription
            return
        }
        viewModel = GitBlamePRViewModel(
            gitRemoteStandardOutput: remoteOut,
            gitBlamePRStandardOutput: blamePROut
        )!
    }

    private func executeGitRemote() throws -> String {
        return try Process.run(
            executableURL: URL(fileURLWithPath: "/usr/bin/git"),
            arguments: ["remote", "-v"],
            currentDirectoryURL: fullPathDirectoryURL
        )
    }

    private func executeGitBlamePR() throws -> String {
        return try Process.run(
            executableURL: URL(fileURLWithPath: "/usr/bin/perl"),
            arguments: [Bundle.main.resourcePath! + "/git-blame-pr.pl", trimedFullPath],
            currentDirectoryURL: fullPathDirectoryURL
        )
    }
}

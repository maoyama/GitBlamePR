//
//  ApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/14.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

class ApplicationService: ObservableObject {
    @Published private(set) var viewModel: GitBlamePRViewModel
    private var historyRepository: HistoryRepository

    init(error: String="") {
        self.historyRepository = HistoryRepository()
        self.viewModel = GitBlamePRViewModel(
            lines: [],
            recent: RecentViewModel(for: self.historyRepository.findAll()),
            error: error
        )
    }

    convenience init(fullPath: FileFullPath) {
        self.init()
        fullPathDidCommit(fullPath: fullPath)
    }

    func clearHistory() {
        do {
            try historyRepository.save(history: History(inputFullPaths: []))
        } catch let e {
            viewModel.error = e.localizedDescription
        }
        viewModel.recent = RecentViewModel(fullPaths: [])
    }

    func fullPathDidCommit(fullPath: FileFullPath) {
        var remoteOut = ""
        var blamePROut = ""
        do {
            remoteOut = try executeGitRemote(fullPath: fullPath)
            blamePROut = try executeGitBlamePR(fullPath: fullPath)
        } catch ProcessError.standardError(let description) {
            viewModel = GitBlamePRViewModel()
            viewModel.error = description
            viewModel.recent = RecentViewModel(for: historyRepository.findAll())
            return
        } catch let e {
            viewModel = GitBlamePRViewModel()
            viewModel.error = e.localizedDescription
            viewModel.recent = RecentViewModel(for: historyRepository.findAll())
            return
        }

        var history = historyRepository.findAll()
        history.addInputFullPath(fullPath.rawValue)
        do {
            try historyRepository.save(history: history)
        } catch let e {
            viewModel.error = e.localizedDescription
        }
        viewModel = GitBlamePRViewModel(
            gitRemoteStandardOutput: remoteOut,
            gitBlamePRStandardOutput: blamePROut
        )!
        viewModel.recent = RecentViewModel(fullPaths: [])

    }

    func fullPathDidCommit(fullPathTextFieldValue: String) {
        guard let fullPath = FileFullPath(rawValue: fullPathTextFieldValue) else {
            viewModel = GitBlamePRViewModel()
            viewModel.recent = RecentViewModel(for: historyRepository.findAll())
            return
        }
        fullPathDidCommit(fullPath: fullPath)
    }

    private func executeGitRemote(fullPath: FileFullPath) throws -> String {
        return try Process.run(
            executableURL: URL(fileURLWithPath: "/usr/bin/git"),
            arguments: ["remote", "-v"],
            currentDirectoryURL: fullPath.directoryURL
        )
    }

    private func executeGitBlamePR(fullPath: FileFullPath) throws -> String {
        return try Process.run(
            executableURL: URL(fileURLWithPath: "/usr/bin/perl"),
            arguments: [Bundle.main.resourcePath! + "/git-blame-pr.pl", fullPath.trimmed],
            currentDirectoryURL: fullPath.directoryURL
        )
    }
}

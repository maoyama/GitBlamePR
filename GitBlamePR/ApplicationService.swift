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
                viewModel.recent = RecentViewModel(for: historyRepository.findAll())
                return
            }
            execute()
        }
    }
    @Published private(set) var viewModel: GitBlamePRViewModel
    private var historyRepository: HistoryRepository
    private var trimedFullPath: String {
        fullPath.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private var fullPathDirectoryURL: URL {
        URL(fileURLWithPath: trimedFullPath).deletingLastPathComponent()
    }

    init() {
        self.historyRepository = HistoryRepository()
        self.viewModel = GitBlamePRViewModel(
            lines: [],
            recent: RecentViewModel(for: self.historyRepository.findAll())
        )
    }

    func clearHistory() {
        do {
            try historyRepository.save(history: History(inputFullPaths: []))
        } catch let e {
            viewModel.error = e.localizedDescription
        }
        viewModel.recent = RecentViewModel(fullPaths: [])
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
            viewModel.recent = RecentViewModel(for: historyRepository.findAll())
            return
        } catch let e {
            viewModel = GitBlamePRViewModel()
            viewModel.error = e.localizedDescription
            viewModel.recent = RecentViewModel(for: historyRepository.findAll())
            return
        }

        var history = historyRepository.findAll()
        history.addInputFullPath(fullPath)
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

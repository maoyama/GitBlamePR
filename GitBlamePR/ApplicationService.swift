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
            execute()
        }
    }
    private var fullPathDirectoryPath: String {
        return URL(fileURLWithPath: fullPath).deletingLastPathComponent().path
    }
    @Published var viewModel = GitBlamePRViewModel(lines: [])

    func execute() {
        viewModel = GitBlamePRViewModel(
            gitRemoteStandardOutput: executeGitRemote()!,
            gitBlamePRStandardOutput: executeGitBlamePR()!
        )!
    }

    private func executeGitRemote() -> String? {
        let process = Process()
        let stdOutput = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
        process.arguments = ["remote", "-v"]
        process.currentDirectoryPath = fullPathDirectoryPath
        process.standardOutput = stdOutput
        try! process.run()
        return String(data: stdOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
    }

    private func executeGitBlamePR() -> String? {
        let path = Bundle.main.resourcePath!;
        let process = Process()
        let stdOutput = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/perl")
        process.arguments = [path + "/git-blame-pr.pl", fullPath]
        process.currentDirectoryPath = fullPathDirectoryPath
        process.standardOutput = stdOutput
        try! process.run()
        return String(data: stdOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
    }


}

extension GitBlamePRViewModel {
    init?(gitRemoteStandardOutput: String, gitBlamePRStandardOutput: String) {
        guard let repo = gitRemoteStandardOutput
            .components(separatedBy: .newlines)[0]
            .components(separatedBy: "github.com:")
            .last?
            .components(separatedBy: ".git")
            .first else { return nil }
        let repoURL = "https://github.com/" + repo

        let strLines = gitBlamePRStandardOutput.components(separatedBy: .newlines)
        self.lines = strLines.map { (line) -> (message: String, url: URL, code: String, id: UUID) in
            let linePrefix = line.prefix(9)
            let code = line.suffix(line.count - linePrefix.count)
            let trimdlinePrefix = linePrefix.trimmingCharacters(in: .whitespacesAndNewlines)
            let message = trimdlinePrefix.replacingOccurrences(of: "^", with: "")
            return (
                message: message,
                url: Self.url(message: message, repoURL: repoURL),
                code: String(code),
                id: UUID()
            )
        }
    }

    private static func url(message: String, repoURL: String) -> URL {
        if message.contains("PR") {
            let prNumber = message.components(separatedBy: "#").last!
            return URL(string: repoURL + "/pull/" + prNumber)!
        }
        return URL(string: repoURL + "/commit/" + message)!
    }
}

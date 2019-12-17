//
//  ApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/14.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

enum ApplicationServiceError: Error {
    case unknown
    case standardError(String)
}

class ApplicationService: ObservableObject {
    var fullPath: String = "" {
        didSet {
            execute()
        }
    }
    @Published private(set) var viewModel = GitBlamePRViewModel(lines: [])
    private var trimedFullPath: String {
        fullPath.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private var fullPathDirectoryPath: String {
        URL(fileURLWithPath: trimedFullPath).deletingLastPathComponent().path
    }

    func execute() {
        var remoteOut = ""
        var blamePROut = ""
        do {
            remoteOut = try executeGitRemote()
            blamePROut = try executeGitBlamePR()
        } catch ApplicationServiceError.standardError(let description) {
            viewModel = GitBlamePRViewModel(lines: [], error: description)
            return
        } catch let e {
            viewModel = GitBlamePRViewModel(lines: [], error: e.localizedDescription)
            return
        }
        viewModel = GitBlamePRViewModel(
            gitRemoteStandardOutput: remoteOut,
            gitBlamePRStandardOutput: blamePROut
        )!
    }

    private func executeGitRemote() throws -> String {
        return try runProcess(
            executableURL: URL(fileURLWithPath: "/usr/bin/git"),
            arguments: ["remote", "-v"],
            currentDirectoryPath: fullPathDirectoryPath
        )
    }

    private func executeGitBlamePR() throws -> String {
        return try runProcess(
            executableURL: URL(fileURLWithPath: "/usr/bin/perl"),
            arguments: [Bundle.main.resourcePath! + "/git-blame-pr.pl", trimedFullPath],
            currentDirectoryPath: fullPathDirectoryPath
        )
    }

    private func runProcess(executableURL: URL, arguments: [String], currentDirectoryPath: String) throws -> String {
        let process = Process()
        let stdOutput = Pipe()
        let stdError = Pipe()
        process.executableURL = executableURL
        process.arguments = arguments
        process.currentDirectoryPath = currentDirectoryPath
        process.standardOutput = stdOutput
        process.standardError = stdError
        try process.run()
        guard let errOut = String(data: stdError.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            throw ApplicationServiceError.unknown
        }
        guard errOut.isEmpty else {
            throw ApplicationServiceError.standardError(errOut)
        }
        guard let stdOut = String(data: stdOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            throw ApplicationServiceError.unknown
        }
        return stdOut

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



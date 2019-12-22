//
//  GitBlamePRViewModel+Init.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

extension GitBlamePRViewModel {
    init() {
        self.lines = []
        self.recent = RecentViewModel(fullPaths: [])
        self.error = ""
    }

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
        self.recent = RecentViewModel(fullPaths: [])
    }

    private static func url(message: String, repoURL: String) -> URL {
        if message.contains("PR") {
            let prNumber = message.components(separatedBy: "#").last!
            return URL(string: repoURL + "/pull/" + prNumber)!
        }
        return URL(string: repoURL + "/commit/" + message)!
    }
}
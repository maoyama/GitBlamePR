//
//  Line.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct Source {
    var lines: [Line]

    init?(gitRemoteStandardOutput: String, gitBlamePRStandardOutput: String) {
        guard let repoURL = RepositoryURL(gitRemoteStandardOutput: gitRemoteStandardOutput) else {
            return nil
        }

        let strLines = gitBlamePRStandardOutput.components(separatedBy: .newlines).dropLast()
        let lines = try? strLines.enumerated().map { (arg) -> Line in
            let (index, line) = arg
            let separatedBy = ","
            let splitted = line.components(separatedBy: separatedBy)
            let linePrefix = splitted[0]
            let code = line.suffix(max(line.count - (linePrefix.count + separatedBy.count), 0))
            guard let revision =  Revision(gitBlamePRStandardOutputLine: line, repositoryURL: repoURL) else {
                throw NSError()
            }
            return Line(
                revision: revision,
                number: LineNumber(value: index + 1)!,
                code: String(code)
            )
        }
        if let lines = lines {
            self.lines = lines
            return
        }
        return nil
    }
}

struct Line {
    var revision: Revision
    var number: LineNumber
    var code: String
}

enum Revision {
    case pullRequest(PullRequest)
    case commit(Commit)
    case notCommited

    init?(gitBlamePRStandardOutputLine: String, repositoryURL: RepositoryURL) {
        let separatedBy = ","
        let splitted = gitBlamePRStandardOutputLine.components(separatedBy: separatedBy)
        let linePrefix = splitted[0]
        let trimmedLinePrefix = linePrefix.trimmingCharacters(in: .whitespacesAndNewlines)
        let revisionStr = trimmedLinePrefix.replacingOccurrences(of: "^", with: "")

        if revisionStr.contains("PR"),
            let prNumberStr = revisionStr.components(separatedBy: "#").last,
            let prNumber = Int(prNumberStr),
            let pr = PullRequest(number: prNumber, repositoryURL:repositoryURL)
        {
            self = .pullRequest(pr)
            return
        }
        if revisionStr.contains("Not Committed") {
            self = .notCommited
            return
        }
        if let commit = Commit(hash: revisionStr, repositoryURL:repositoryURL) {
            self = .commit(commit)
            return
        }

        return nil
    }

    var discription: String {
        switch self {
        case .pullRequest(let pr):
            return "PR #\(pr.number)"
        case .commit(let commit):
            return "\(commit.hash)"
        case .notCommited:
            return "Not Committed"
        }
    }

    var url: URL? {
        switch self {
        case .pullRequest(let pr):
            return pr.url
        case .commit(let commit):
            return commit.url
        case .notCommited:
            return nil
        }
    }
}

struct PullRequest {
    private(set) var number: Int
    private(set) var url: URL

    init?(number: Int, repositoryURL: RepositoryURL) {
        if number <= 0 {
            return nil
        }
        self.number = number
        self.url = repositoryURL.value.appendingPathComponent("/pull/\(number)")
    }
}

struct Commit {
    private(set) var hash: String
    private(set) var url: URL

    init?(hash: String, repositoryURL: RepositoryURL) {
        if hash.count < 4 {
            return nil
        }
        self.hash = hash
        self.url = repositoryURL.value.appendingPathComponent("/commit/\(hash)")
    }
}

struct LineNumber {
    private(set) var value: Int

    init?(value: Int) {
        if value <= 0 {
            return nil
        }
        self.value = value
    }
}

struct RepositoryURL {
    private(set) var value: URL

    init?(gitRemoteStandardOutput: String) {
        guard let repo = gitRemoteStandardOutput
            .components(separatedBy: .newlines)[0]
            .components(separatedBy: "github.com:")
            .last?
            .components(separatedBy: ".git")
            .first
            else {
                return nil
            }
        guard let repoURL = URL(string: "https://github.com/" + repo) else {
            return nil
        }
        self.value = repoURL
    }
}

//
//  Source.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct Source {
    let lines: [Line]

    func selected(by number: LineNumber) -> Source {
        guard let selectedLine = lines.first(where: { $0.number == number }) else {
            return self
        }
        let selectedLines = lines.map { (l) -> Line in
            var new = l
            if new.number == number {
                new.status = .selected
                return new
            }
            if new.revision == selectedLine.revision {
                new.status = .related
                return new
            }
            new.status = .none
            return new
        }
        return Source(lines: selectedLines)
    }
}

extension Source {
    init(from remote: GitRemoteCommand, command blamePR: GitBlamePRCommand) throws {
        let ro = try remote.standardOutput()
        let bo = try blamePR.standardOutput()
        try self.init(gitRemoteStandardOutput: ro, gitBlamePRStandardOutput: bo)
    }

    init(gitRemoteStandardOutput: String, gitBlamePRStandardOutput: String) throws {
        guard let repoURL = GitRepository(gitRemoteStandardOutput: gitRemoteStandardOutput) else {
            throw CommandError.parse
        }

        let strLines = gitBlamePRStandardOutput.components(separatedBy: .newlines).dropLast()
        let lines = try? strLines.enumerated().map { (arg) -> Line in
            let (index, line) = arg
            let separatedBy = ","
            let splitted = line.components(separatedBy: separatedBy)
            let linePrefix = splitted[0]
            let code = line.suffix(max(line.count - (linePrefix.count + separatedBy.count), 0))
            guard let revision =  Revision(gitBlamePRStandardOutputLine: line, repository: repoURL) else {
                throw CommandError.parse
            }
            return Line(
                revision: revision,
                number: LineNumber(index + 1)!,
                code: String(code),
                status: .none
            )
        }
        if let lines = lines {
            self.lines = lines
            return
        }
        throw CommandError.parse
    }
}

struct Line {
    var revision: Revision
    var number: LineNumber
    var code: String
    var status: LineStatus
}

enum LineStatus {
    case selected, related, none
}


enum Revision: Equatable {
    static func == (lhs: Revision, rhs: Revision) -> Bool {
        guard
            let lhsURL = lhs.url,
            let rhsURL = rhs.url
        else {
            return false
        }
        return lhsURL == rhsURL
    }

    case pullRequest(SourcePullRequest)
    case commit(SourceCommit)
    case notCommited

    var description: String {
        switch self {
        case .pullRequest(let pr):
            return "PR #\(pr.number)"
        case .commit(let commit):
            return "\(commit.hash)"
        case .notCommited:
            return "-"
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

extension Revision {
    init?(gitBlamePRStandardOutputLine: String, repository: GitRepository) {
        let separatedBy = ","
        let splitted = gitBlamePRStandardOutputLine.components(separatedBy: separatedBy)
        let linePrefix = splitted[0]
        let trimmedLinePrefix = linePrefix.trimmingCharacters(in: .whitespacesAndNewlines)
        let revisionStr = trimmedLinePrefix.replacingOccurrences(of: "^", with: "")

        if revisionStr.contains("PR"),
            let prNumberStr = revisionStr.components(separatedBy: "#").last,
            let prNumber = Int(prNumberStr),
            let pr = SourcePullRequest(number: prNumber, repository:repository)
        {
            self = .pullRequest(pr)
            return
        }
        if revisionStr.contains("Not Committed") {
            self = .notCommited
            return
        }
        if let commit = SourceCommit(hash: revisionStr, repository:repository) {
            self = .commit(commit)
            return
        }

        return nil
    }
}

struct SourcePullRequest {
    private(set) var number: Int
    private(set) var repository: GitRepository
    var url: URL {
        repository.html.appendingPathComponent("/pull/\(number)")
    }

    init?(number: Int, repository: GitRepository) {
        if number <= 0 {
            return nil
        }
        self.number = number
        self.repository = repository
    }
}

struct SourceCommit {
    private(set) var hash: String
    private(set) var url: URL

    init?(hash: String, repository: GitRepository) {
        if hash.count < 4 {
            return nil
        }
        self.hash = hash
        self.url = repository.html.appendingPathComponent("/commit/\(hash)")
    }
}

struct LineNumber: Equatable {
    static func == (lhs: LineNumber, rhs: LineNumber) -> Bool {
        return lhs.value == rhs.value
    }

    private(set) var value: Int

    init?(_ value: Int) {
        if value <= 0 {
            return nil
        }
        self.value = value
    }

}

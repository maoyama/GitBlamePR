//
//  GitBlamePRViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct SourceViewModel {
    var lines: [LineViewModel]
    var error = ""
}

extension SourceViewModel {
    init() {
        self.lines = []
        self.error = ""
    }

    init(source: Source) {
        self.lines = source.lines.map { (line) -> LineViewModel in
            return LineViewModel(
                revision: SourceRevisionViewModel(from: line.revision),
                url: line.revision.url,
                code: line.code,
                number: line.number.value,
                status: .init(from: line.status)
            )
        }
    }
}

struct LineViewModel {
    enum Status {
        case selected, related, none
        init(from status: LineStatus) {
            switch status {
            case .selected:
                self = .selected
            case .related:
                self = .related
            case .none:
                self = .none
            }
        }
    }

    var revision: SourceRevisionViewModel
    var url: URL?
    var code: String
    var number: Int
    var numberLabel: String { "\(number)"}
    var status: Status
}

struct SourceRevisionViewModel {
    var description: String
    var pullRequest: (number: Int, owner: String, repository: String)?
    var commitHash: String?
    var numberLabel: String {
        if let _ = pullRequest {
            return "Pull Request Number"
        } else {
            return "Commit Hash"
        }
    }
    var numberValue: String {
        if let p = pullRequest {
            return "\(p.number)"
        } else {
            return commitHash ?? ""
        }
    }
}

extension SourceRevisionViewModel {
    init(from revison: Revision) {
        description = revison.description
        switch revison {
        case .pullRequest(let pr):
            pullRequest = (number: pr.number, owner: pr.repository.ownerName, repository: pr.repository.name)
            commitHash = nil
            return
        case .commit(let commit):
            commitHash = commit.hash
            pullRequest = nil
        case .notCommited:
            pullRequest = nil
            commitHash = nil
        }
    }
}

//
//  GitBlamePRViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct SourceViewModel {
    var lines: [(revision: SourceRevisionViewModel, url: URL?, code: String, number: Int)]
    var recent: RecentViewModel
    var error = ""
    var hoveredRevision: (commitHash: String?, pullRequestNumber: Int?, pullRequestOwner: String?, pullRequestRepositoryName: String?) 
}

extension SourceViewModel {
    init() {
        self.lines = []
        self.recent = RecentViewModel(fullPaths: [])
        self.error = ""
    }

    init(source: Source) {
        self.lines = source.lines.map { (line) -> (revision: SourceRevisionViewModel, url: URL?, code: String, number: Int) in
            return (
                revision: SourceRevisionViewModel(from: line.revision),
                url: line.revision.url,
                code: line.code,
                number: line.number.value
            )
        }
        self.recent = RecentViewModel(fullPaths: [])
    }
}

struct SourceRevisionViewModel {
    var description: String
    var pullRequest: (number: Int, owner: String, repository: String)?
    var commitHash: String?
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

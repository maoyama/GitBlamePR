//
//  GitBlamePRViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct SourceViewModel {
    var lines: [(revision: String, url: URL?, code: String, number: Int)]
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
        self.lines = source.lines.map { (line) -> (revision: String, url: URL?, code: String, number: Int) in
            return (
                revision: line.revision.discription,
                url: line.revision.url,
                code: line.code,
                number: line.number.value
            )
        }
        self.recent = RecentViewModel(fullPaths: [])
    }
}

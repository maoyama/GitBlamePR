//
//  GitBlamePRViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct SourceViewModel {
    var lines: [(message: String, url: URL?, code: String, number: Int)]
    var recent: RecentViewModel
    var error = ""
}

extension SourceViewModel {
    init() {
        self.lines = []
        self.recent = RecentViewModel(fullPaths: [])
        self.error = ""
    }

    init(source: Source) {
        self.lines = source.lines.map { (line) -> (message: String, url: URL?, code: String, number: Int) in
            return (
                message: line.revision.discription,
                url: line.revision.url,
                code: line.code,
                number: line.number.value
            )
        }
        self.recent = RecentViewModel(fullPaths: [])
    }
}

//
//  GitBlamePRViewModel+Init.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

extension SourceViewModel {
    init() {
        self.lines = []
        self.recent = RecentViewModel(fullPaths: [])
        self.error = ""
    }

    init(source: Source) {
        self.lines = source.lines.map { (line) -> (message: String, url: URL?, code: String, id: UUID) in
            return (
                message: line.revision.discription,
                url: line.revision.url,
                code: line.code,
                id: UUID()
            )
        }
        self.recent = RecentViewModel(fullPaths: [])
    }
}

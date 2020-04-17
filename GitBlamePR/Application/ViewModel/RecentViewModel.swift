//
//  RecentViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct RecentViewModel {
    var fullPaths: [(value: String, id: UUID)]
}

extension RecentViewModel {
    init(history: History) {
        self.fullPaths = history.inputFullPaths.map({ (string) -> (String, UUID) in
            (string, UUID())
        })
    }
}

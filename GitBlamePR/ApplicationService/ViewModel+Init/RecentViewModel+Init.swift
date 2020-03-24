//
//  RecentViewModel+Init.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

extension RecentViewModel {
    init(history: History) {
        self.fullPaths = history.inputFullPaths.map({ (string) -> (String, UUID) in
            (string, UUID())
        })
    }
}

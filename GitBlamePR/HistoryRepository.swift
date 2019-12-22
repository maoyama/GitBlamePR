//
//  HistoryRepository.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct HistoryRepository {
    private let db: UserDefaults

    init(db: UserDefaults = UserDefaults.standard) {
        self.db = db
    }

    func findAll() -> History {
        let fullPaths = db.array(forKey: .fullPathHistory) as! [URL]
        return History(fullPaths: fullPaths)
    }

    func save(history: History) {
        db.set(history.fullPaths, forKey: .fullPathHistory)
    }
}

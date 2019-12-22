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
        if let data = db.data(forKey: .fullPathHistory) {
            if let fullPaths = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
                return History(inputFullPaths: fullPaths)
            }
        }
        return History(inputFullPaths: [])
    }

    func save(history: History) throws {
        let data = try NSKeyedArchiver.archivedData(withRootObject: history.inputFullPaths, requiringSecureCoding: true)
        db.set(data, forKey: .fullPathHistory)
    }
}

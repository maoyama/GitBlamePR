//
//  UserDefaults+Key.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case fullPathHistory
    }

    func data(forKey key: UserDefaults.Key) -> Data? {
        data(forKey: key.rawValue)
    }

    func set(_ value: Any?, forKey key: UserDefaults.Key) {
        set(value, forKey: key.rawValue)
    }
}

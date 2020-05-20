//
//  PersonalAccessToken.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct PersonalAccessToken: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return
            lhs.rawValue == rhs.rawValue
    }

    let rawValue: String

    init?(_ rawValue: String) {
        if rawValue.count < 1 {
            return nil
        }
        self.rawValue = rawValue
    }
}

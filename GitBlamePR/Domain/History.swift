//
//  History.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct History {
    static var inputFullPathLimit = 100
    private(set) var inputFullPaths: [String]

    private static func validate(forInputFullPaths fullPaths: [String]) -> [String] {
        return Array(fullPaths.prefix(inputFullPathLimit)).unique
    }

    init(inputFullPaths: [String]) {
        self.inputFullPaths = Self.validate(forInputFullPaths: inputFullPaths)
    }

    mutating func addInputFullPath(_ string: String) {
        inputFullPaths.insert(string, at: 0)
        inputFullPaths = Self.validate(forInputFullPaths: inputFullPaths)
    }
}

extension Array where Element: Equatable {
    var unique: [Element] {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}

//
//  History.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct History {
    static var fullPathLimit = 100
    private(set) var fullPaths: [URL]

    private static func validate(forFullPaths fullPaths: [URL]) -> [URL] {
        return Array(fullPaths.prefix(fullPathLimit)).unique
    }

    init(fullPaths: [URL]) {
        self.fullPaths = Self.validate(forFullPaths: fullPaths)
    }

    mutating func addFullPath(_ url: URL) {
        fullPaths.insert(url, at: 0)
        fullPaths = Self.validate(forFullPaths: fullPaths)
    }
}

extension Array where Element: Equatable {
    var unique: [Element] {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}

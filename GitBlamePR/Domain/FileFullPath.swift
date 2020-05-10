//
//  FileFullPath.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/15.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct FileFullPath: Equatable {
    static func == (lhs: FileFullPath, rhs: FileFullPath) -> Bool {
        return
            lhs.rawValue == rhs.rawValue
    }

    var rawValue: String
    var trimmed: String {
        rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var directoryURL: URL {
        URL(fileURLWithPath: trimmed).deletingLastPathComponent()
    }

    init?(rawValue: String) {
        if rawValue.count < 2 {
            return nil
        }
        self.rawValue = rawValue
    }

}

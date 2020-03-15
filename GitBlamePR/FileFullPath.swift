//
//  FileFullPath.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/15.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct FileFullPath {
    var rawValue: String
    var trimmed: String {
        rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var directoryURL: URL {
        URL(fileURLWithPath: trimmed).deletingLastPathComponent()
    }

    init?(rawValue: String) {
        if rawValue.isEmpty {
            return nil
        }
        self.rawValue = rawValue
    }
}

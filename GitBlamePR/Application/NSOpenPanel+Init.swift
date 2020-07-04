//
//  NSOpenPanel+Init.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/07/03.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation
import AppKit

extension NSOpenPanel {
    convenience init(filePath: String) {
        self.init()
        canChooseFiles = true
        canChooseDirectories = false
        allowsMultipleSelection = false
        directoryURL = FileFullPath(rawValue: filePath)?.directoryURL
    }
}

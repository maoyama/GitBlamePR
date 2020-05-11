//
//  Enviroment.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/04/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct Enviroment {
    static let sourceRootDirectory = URL(
        fileURLWithPath: ProcessInfo.processInfo.environment["SRCROOT"]!,
        isDirectory: true
    )
}

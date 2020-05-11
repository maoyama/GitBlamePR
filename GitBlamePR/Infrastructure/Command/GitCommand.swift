//
//  GitCommand.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/19.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

protocol GitCommand: Command {}

extension GitCommand {
    var executableURL: URL {
        URL(fileURLWithPath: "/usr/bin/git")
    }
}

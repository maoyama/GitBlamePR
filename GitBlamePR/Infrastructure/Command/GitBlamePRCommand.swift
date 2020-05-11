//
//  GitBlamePRCommand.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/11.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct GitBlamePRCommand: Command {
    var executableURL: URL {
        URL(fileURLWithPath: "/usr/bin/perl")
    }
    var path: FileFullPath
    var arguments: [String] {
        [Bundle.main.resourcePath! + "/git-blame-pr.pl", path.trimmed]
    }
    var directoryURL: URL {
        path.directoryURL
    }
}

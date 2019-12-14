//
//  ApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/14.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

class ApplicationService {

    init() {
        getRemote()
    }

    func getRemote() {
        let process = Process()
        let output = Pipe()
        process.launchPath = "/usr/bin/git"
        process.arguments = ["remove", "-v"]
        process.currentDirectoryPath = "/Users/aoyama/Projects/SpreadsheetView"
        process.standardOutput = output
        process.launch()
        print(output)
    }

}

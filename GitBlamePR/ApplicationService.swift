//
//  ApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/14.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

class ApplicationService {
    var fileFullPath = "/Users/aoyama/Projects/SpreadsheetView"

    init() {
        executeGitRemote()
        executeGitBlamePR()
    }

    private func executeGitRemote() {
        let process = Process()
        let stdOutput = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
        process.arguments = ["remote", "-v"]
        process.currentDirectoryPath = fileFullPath
        process.standardOutput = stdOutput
        try! process.run()
        let output = String(data: stdOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        print(output!)
    }

    private func executeGitBlamePR() {
        let path = Bundle.main.resourcePath!;
        let process = Process()
        let stdOutput = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/perl")
        process.arguments = [path + "/git-blame-pr.pl", fileFullPath + "/README.md"]
        process.currentDirectoryPath = fileFullPath
        process.standardOutput = stdOutput
        try! process.run()
        let output = String(data: stdOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        print(output!)
    }


}

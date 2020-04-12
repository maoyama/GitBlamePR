//
//  Command.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/11.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct CommandError: Error, LocalizedError {
    static var unknown = CommandError(description: "Unknown error.")

    private var description: String
    var errorDescription: String? {
        return description
    }

    init(description: String) {
        self.description = description
    }

    init(error: Error) {
        self.init(description: error.localizedDescription)
    }
}

protocol Command {
    var executableURL: URL { get }
    var arguments: [String] { get }
    var directoryURL: URL { get }

    func output() throws -> String
}

extension Command {
    func output() throws -> String {
        return try output(executableURL: executableURL, arguments: arguments, currentDirectoryURL: directoryURL)
    }

    private func output(executableURL: URL, arguments: [String], currentDirectoryURL: URL) throws -> String {
        let process = Process()
        process.executableURL = executableURL
        process.arguments = arguments
        process.currentDirectoryURL = currentDirectoryURL

        let stdOutput = Pipe()
        let stdError = Pipe()
        process.standardOutput = stdOutput
        process.standardError = stdError
        do {
            try process.run()
        } catch let e {
            throw CommandError(error: e)
        }
        guard let errOut = String(data: stdError.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            throw CommandError.unknown
        }
        guard errOut.isEmpty else {
            throw CommandError(description: errOut)
        }
        guard let stdOut = String(data: stdOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            throw CommandError.unknown
        }
        return stdOut
    }
}

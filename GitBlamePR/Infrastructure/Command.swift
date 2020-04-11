//
//  Command.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/11.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct CommandError: Error, LocalizedError {
    private var description: String
    var errorDescription: String? {
        return description
    }

    init(description: String) {
        self.description = description
    }
}

struct Command<T: CommandAttributes>{
    private var attributes: T
    private var currentDirectoryURL: URL
    private var process: CommandProcess

    init(attributes: T, directoryURL: URL, process: CommandProcess=DefaultCommandProcess()) {
        self.attributes = attributes
        self.currentDirectoryURL = directoryURL
        self.process = process
    }

    func execute() throws -> String {
        do {
            return try process.run(
                executableURL: attributes.executableURL,
                arguments: attributes.arguments,
                currentDirectoryURL: currentDirectoryURL
            )
        } catch ProcessError.standardError(let description) {
            throw CommandError(description: description)
        } catch let e {
            throw CommandError(description: e.localizedDescription)
        }
    }
}

protocol CommandAttributes {
    var executableURL: URL { get }
    var arguments: [String] { get }
}

protocol CommandProcess {
    func run(executableURL: URL, arguments: [String], currentDirectoryURL: URL) throws -> String
}

struct DefaultCommandProcess: CommandProcess {
    func run(executableURL: URL, arguments: [String], currentDirectoryURL: URL) throws -> String {
        let process = Process()
        process.executableURL = executableURL
        process.arguments = arguments
        process.currentDirectoryURL = currentDirectoryURL

        let stdOutput = Pipe()
        let stdError = Pipe()
        process.standardOutput = stdOutput
        process.standardError = stdError
        try process.run()
        guard let errOut = String(data: stdError.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            throw ProcessError.unknown
        }
        guard errOut.isEmpty else {
            throw ProcessError.standardError(errOut)
        }
        guard let stdOut = String(data: stdOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            throw ProcessError.unknown
        }
        return stdOut
    }
}

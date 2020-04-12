//
//  CommitDetailTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class CommitDetailTests: XCTestCase {

    func testInit() throws {
        let root = URL(fileURLWithPath: ProcessInfo.processInfo.environment["SRCROOT"]!,  isDirectory: true)
        print(try! GitShowCommand(commitHash: "69bbda5980b6042434b2f391817c0a6050aa6a62", directoryURL: root).output())
    }
}

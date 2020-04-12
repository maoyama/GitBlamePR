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
        let root = ProcessInfo.processInfo.environment["SRCROOT"]!
        let gs = GitShow(commitHash: "69bbda5980b6042434b2f391817c0a6050aa6a62")
        print(try! Command(attributes: gs, directoryURL: URL(fileURLWithPath: root, isDirectory: true)).execute())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

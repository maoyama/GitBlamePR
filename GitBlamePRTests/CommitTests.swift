//
//  CommitTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class CommitTests: XCTestCase {

    func testInit() throws {
        let hash = "3e8a2eb172cefce4d28301ccc0df687926e3a0e4"
        let command = GitShowCommand(
            commitHash: hash,
            directoryURL: Enviroment.sourceRootDirectory
        )
        let commit = try! Commit(from: command)
        XCTAssertEqual(commit.hash, hash)
        XCTAssertEqual(commit.author, "Makoto Aoyama")
        XCTAssertEqual(commit.authorEmail, "m@aoyama.dev")
        XCTAssertEqual(commit.authorDate, ISO8601DateFormatter().date(from: "2020-03-26T23:09:47+09:00")!)
        XCTAssertEqual(commit.committer, "GitHub")
        XCTAssertEqual(commit.committerEmail, "noreply@github.com")
        XCTAssertEqual(commit.authorDate, ISO8601DateFormatter().date(from: "2020-03-26T23:09:47+09:00")!)
        XCTAssertEqual(commit.titleLine, "Merge pull request #17 from maoyama/fix-not-commited")
        XCTAssertEqual(commit.fullCommitMessage, "Fix git blame pr command failure when not commited")
    }

    func testInitEmptyFullCommitMessage() throws {
        let hash = "bf97c67"
        let command = GitShowCommand(
            commitHash: hash,
            directoryURL: Enviroment.sourceRootDirectory
        )
        let commit = try! Commit(from: command)
        XCTAssertEqual(commit.fullCommitMessage, "")
    }
}


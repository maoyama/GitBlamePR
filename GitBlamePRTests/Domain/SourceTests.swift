//
//  SourceTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/05/16.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class SourceTests: XCTestCase {

    func testSelectCommit() throws {
        let rev1: Revision = .commit(
            SourceCommit(hash: "commit1", repository: GitRepository(ownerName: "maoyama", name: "repo"))!
        )
        let rev2: Revision = .commit(
            SourceCommit(hash: "commit2", repository: GitRepository(ownerName: "maoyama", name: "repo"))!
        )

        let s = Source(lines: [
            Line(revision: rev1, number: LineNumber(1)!, code: "//", status: .none),
            Line(revision: rev1, number: LineNumber(2)!, code: "//", status: .none),
            Line(revision: rev1, number: LineNumber(3)!, code: "//", status: .none),
            Line(revision: rev2, number: LineNumber(4)!, code: "//", status: .none),
        ])
        let selected = s.selected(by: LineNumber(2)!)
        XCTAssertEqual(selected.lines[0].status, LineStatus.related)
        XCTAssertEqual(selected.lines[1].status, LineStatus.selected)
        XCTAssertEqual(selected.lines[2].status, LineStatus.related)
        XCTAssertEqual(selected.lines[3].status, LineStatus.none)
    }

    func testSelectPR() throws {
        let rev1: Revision = .pullRequest(
            SourcePullRequest(
                number: 1,
                repository: GitRepository(ownerName: "maoyama", name: "repo")
            )!
        )
        let rev2: Revision = .pullRequest(
            SourcePullRequest(
                number: 2,
                repository: GitRepository(ownerName: "maoyama", name: "repo")
            )!
        )

        let s = Source(lines: [
            Line(revision: rev1, number: LineNumber(1)!, code: "//", status: .none),
            Line(revision: rev1, number: LineNumber(2)!, code: "//", status: .none),
            Line(revision: rev1, number: LineNumber(3)!, code: "//", status: .none),
            Line(revision: rev2, number: LineNumber(4)!, code: "//", status: .none),
        ])
        let selected = s.selected(by: LineNumber(2)!)
        XCTAssertEqual(selected.lines[0].status, LineStatus.related)
        XCTAssertEqual(selected.lines[1].status, LineStatus.selected)
        XCTAssertEqual(selected.lines[2].status, LineStatus.related)
        XCTAssertEqual(selected.lines[3].status, LineStatus.none)
    }

    func testSelectNotCommited() throws {
        let rev1: Revision = .notCommited
        let rev2: Revision = .pullRequest(
            SourcePullRequest(
                number: 2,
                repository: GitRepository(ownerName: "maoyama", name: "repo")
            )!
        )

        let s = Source(lines: [
            Line(revision: rev1, number: LineNumber(1)!, code: "//", status: .none),
            Line(revision: rev1, number: LineNumber(2)!, code: "//", status: .none),
            Line(revision: rev1, number: LineNumber(3)!, code: "//", status: .none),
            Line(revision: rev2, number: LineNumber(4)!, code: "//", status: .none),
        ])
        let selected = s.selected(by: LineNumber(2)!)
        XCTAssertEqual(selected.lines[0].status, LineStatus.none)
        XCTAssertEqual(selected.lines[1].status, LineStatus.selected)
        XCTAssertEqual(selected.lines[2].status, LineStatus.none)
        XCTAssertEqual(selected.lines[3].status, LineStatus.none)
    }

}

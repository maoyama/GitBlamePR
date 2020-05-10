//
//  SourceCacheTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/05/10.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class SourceCacheTests: XCTestCase {
    func testCache() {
        let key = FileFullPath(rawValue: "/AppDelegate.swift")!
        XCTAssertNil(SourceCache.shared.object(forKey: key))
        let code = "// Hello!"
        let source = Source(
            lines: [.init(revision: .notCommited, number: LineNumber(value: 1)!, code: code)]
        )
        SourceCache.shared.set(source, forKey: key)
        let cached = SourceCache.shared.object(forKey: key)!
        XCTAssertEqual(code, cached.lines[0].code)
    }
}

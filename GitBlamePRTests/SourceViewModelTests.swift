//
//  SourceViewModelTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2019/12/07.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class SourceViewModelTests: XCTestCase {
    let gitRemoteOutput = """
origin    git@github.com:maoyama/GitBlamePR.git (fetch)
origin    git@github.com:maoyama/GitBlamePR.git (push)
"""

    let gitBlamePROutput = """
^e2b41ca,//
^e2b41ca,//  AppDelegate.swift
^e2b41ca,//  GitBlamePR
^e2b41ca,//
^e2b41ca,//  Created by Makoto Aoyama on 2019/12/07.
^e2b41ca,//  Copyright © 2019 dev.aoyama. All rights reserved.
^e2b41ca,//
^e2b41ca,
Not Committed Yet,
^e2b41ca,import Cocoa
^e2b41ca,import SwiftUI
^e2b41ca,
^e2b41ca,@NSApplicationMain
^e2b41ca,class AppDelegate: NSObject, NSApplicationDelegate {
^e2b41ca,    var window: NSWindow!
^e2b41ca,
PR #10   ,    func applicationWillFinishLaunching(_ notification: Notification) {
^e2b41ca,        window = NSWindow(
^e2b41ca,            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
^e2b41ca,            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
^e2b41ca,            backing: .buffered, defer: false)
caf6aa35,        window.title = "GitBlamePR"
^e2b41ca,        window.center()
^e2b41ca,        window.setFrameAutosaveName("Main Window")
PR #16   ,        window.contentView = NSHostingView(rootView: SourceViewWrapper())
^e2b41ca,        window.makeKeyAndOrderFront(nil)
^e2b41ca,    }
^e2b41ca,
PR #10   ,    func application(_ application: NSApplication, open urls: [URL]) {
PR #10   ,        if let urlScheme = URLScheme(url: urls[0]) {
PR #10   ,            switch urlScheme {
PR #10   ,            case .fileFullPath(let fullPath):
PR #10   ,                window?.contentView = NSHostingView(
PR #16   ,                    rootView: SourceViewWrapper(
PR #16   ,                        service: SourceApplicationService(fullPath: fullPath),
PR #10   ,                        fullPathTextFieldValue: fullPath.rawValue
PR #10   ,                    )
PR #10   ,                )
PR #10   ,            case .xcodeFileFullPath:
PR #10   ,                XcodeConnection.resume { [weak self](result) in
PR #10   ,                    switch result {
PR #10   ,                    case .success(let fullPath):
PR #10   ,                        self?.window?.contentView = NSHostingView(
PR #16   ,                            rootView: SourceViewWrapper(
PR #16   ,                                service: SourceApplicationService(fullPath: fullPath),
PR #10   ,                                fullPathTextFieldValue: fullPath.rawValue)
PR #10   ,                        )
PR #10   ,                    case .failure(let error):
PR #10   ,                        self?.window?.contentView = NSHostingView(
PR #16   ,                            rootView: SourceViewWrapper(service: SourceApplicationService(error: error.localizedDescription))
PR #10   ,                        )
PR #10   ,                    }
PR #10   ,                }
PR #10   ,            }
PR #10   ,        } else {
PR #10   ,            window?.contentView = NSHostingView(
PR #16   ,                rootView: SourceViewWrapper(service: SourceApplicationService(error: "URL not found."))
PR #10   ,            )
PR #10   ,        }
^e2b41ca,    }
^e2b41ca,
PR #10   ,    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
PR #10   ,        return true
PR #10   ,    }
^e2b41ca,}
"""

    func testContentViewModelInit() {
        let vm = SourceViewModel(gitRemoteStandardOutput: gitRemoteOutput, gitBlamePRStandardOutput: gitBlamePROutput)!
        XCTAssertEqual(vm.lines.count, 65)
        XCTAssertEqual(vm.lines[16].message, "PR #10")
        XCTAssertEqual(vm.lines[16].url, URL(string: "https://github.com/maoyama/GitBlamePR/pull/10")!)
        XCTAssertEqual(vm.lines[16].code, "    func applicationWillFinishLaunching(_ notification: Notification) {")

        XCTAssertEqual(vm.lines[64].message, "e2b41ca")
        XCTAssertEqual(vm.lines[64].code, "}")

        XCTAssertEqual(vm.lines[8].message, "Not Committed Yet")
        XCTAssertEqual(vm.lines[8].code, "")
        XCTAssertEqual(vm.lines[8].url, nil)
    }
}

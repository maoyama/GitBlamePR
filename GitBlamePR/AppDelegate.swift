//
//  AppDelegate.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/07.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationWillFinishLaunching(_ notification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.title = "GitBlamePR"
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: MainView())
        window.makeKeyAndOrderFront(nil)
        window?.titlebarAppearsTransparent = true
        window?.styleMask = [.closable, .resizable, .fullSizeContentView, .miniaturizable, .titled]
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        if let urlScheme = URLScheme(url: urls[0]) {
            switch urlScheme {
            case .fileFullPath(let fullPath):
                window?.contentView = NSHostingView(
                    rootView: MainView(path: fullPath.rawValue)
                )
            case .xcodeFileFullPath:
                XcodeConnection.resume { [weak self](result) in
                    switch result {
                    case .success(let fullPath):
                        self?.window?.contentView = NSHostingView(
                            rootView: MainView(path: fullPath.rawValue)
                        )
                    case .failure(let error):
                        self?.window?.contentView = NSHostingView(
                            rootView: MainView(error: error.localizedDescription)
                        )
                    }
                }
            }
        } else {
            window?.contentView = NSHostingView(
                rootView: MainView(error: "URL not found.")
            )
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

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


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(
            model: ContentViewModel(lines: [
                (
                    message: "# PR2020",
                    url: URL(string: "https://github.com")!,
                    code: "// hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello"
                ),
                (
                    message: "# PR2021",
                    url: URL(string: "https://github.com")!,
                    code: "// hello"
                ),
                (
                    message: "# fe12b",
                    url: URL(string: "https://github.com")!,
                    code: "// hello"
                ),
            ])
        )

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


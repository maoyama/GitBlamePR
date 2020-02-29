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
    var urlSchemeService: URLSchemeService!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.title = "GitBlamePR"
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: ContentView())
        window.makeKeyAndOrderFront(nil)

        
        // TODO Move connection to xcode
        let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
        connection.resume()
        let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol

        let semaphore = DispatchSemaphore(value: 0)
        xcode.currentFileFullPath { (str) in
            print(str ?? "")
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 10)

        urlSchemeService = URLSchemeService(appWillOpenWithFileFullPath: { [weak window](fullPath) in
            window?.contentView = NSHostingView(rootView: ContentView(fullPath: fullPath))
        })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

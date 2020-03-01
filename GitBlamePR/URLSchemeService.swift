//
//  URLSchemeService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/02/29.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

class URLSchemeService {
    private var willOpen: (_ fullPath: String) -> Void

    init(appWillOpenWithFileFullPath:@escaping (String) -> Void) {
        self.willOpen = appWillOpenWithFileFullPath
        NSAppleEventManager.shared().setEventHandler(
            self,
            andSelector: #selector(handle(event:replyEvent:)),
            forEventClass: AEEventClass(kInternetEventClass),
            andEventID: AEEventID(kAEGetURL)
        )
        let appURL = Bundle.main.bundleURL.appendingPathComponent("", isDirectory: true)
        LSRegisterURL(appURL as CFURL, false)
    }

    @objc func handle(event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
        guard
            let urlStr =  event?.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue,
            let url = URL(string: urlStr),
            let urlScheme = URLScheme(url: url)
        else {
            return
        }
        switch urlScheme {
        case .fileFullPath(let value):
            willOpen(value)
            return
        case .accessToXcode:
            let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
            connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
            connection.resume()
            let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol
            let semaphore = DispatchSemaphore(value: 0)
            xcode.currentFileFullPath { [weak self] (value) in
                semaphore.signal()
                DispatchQueue.main.async {
                    if let value = value {
                        self?.willOpen(value)
                    }
                }
            }
            _ = semaphore.wait(timeout: .now() + 10)
            return
        }
    }
}

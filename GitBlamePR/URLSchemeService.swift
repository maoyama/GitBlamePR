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
        guard let urlStr =  event?.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue else {
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        guard let urlScheme = URLScheme(url: url) else {
            return
        }
        switch urlScheme {
        case .fileFullPath(let value):
            willOpen(value)
            return
        default:
            return
        }
    }
}

//
//  NSPastebord+String.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/08/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import AppKit

extension NSPasteboard {
    static func setString(_ string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(string, forType: NSPasteboard.PasteboardType.string)
    }
}

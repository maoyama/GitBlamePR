//
//  MainHostingView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/08/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import AppKit

class MainHostingView: NSHostingView<MainView> {
    required init(rootView: MainView) {
        super.init(rootView: rootView)
        registerForDraggedTypes([.fileURL, .URL, .string])
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        guard let _ = path(from: sender) else { return [] }
        return .copy
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let path = path(from: sender) else { return false }
        window?.contentView =  MainHostingView(
            rootView: MainView(path: path)
        )
        return true
    }

    private func path(from sender: NSDraggingInfo) -> String? {
        guard let pasteboard = sender.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = pasteboard[0] as? String else {
                return nil
        }
        return path
    }
}

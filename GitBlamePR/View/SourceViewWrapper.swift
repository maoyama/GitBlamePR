//
//  ContentView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/07.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import SwiftUI
import AppKit


struct SourceViewWrapper: View {
    @ObservedObject private var service: SourceApplicationService
    @State private var fullPathTextFieldValue: String = ""

    init(service: SourceApplicationService=SourceApplicationService(), fullPathTextFieldValue: String="") {
        self.service = service
        self.fullPathTextFieldValue = fullPathTextFieldValue
    }

    var body: some View {
        SplitView(
            master: SourceView(
                model: service.viewModel,
                fullPathTextFieldValue: fullPathTextFieldValue,
                textOnCommit: { text in
                    self.service.fullPathDidCommit(fullPathTextFieldValue: text)
                    self.fullPathTextFieldValue = text
                },
                clearOnTap: {
                    self.service.clearHistory()
                },
                revisionOnHover: { lineNumber in
                    self.service.revisionDidHover(lineNumber: lineNumber)
                }
            ),
            detail: RevisionViewWrapper(service: RevisionApplicationService(commitHash: service.viewModel.hoveredRevision, fullPathTextFieldValue: fullPathTextFieldValue))
        )
    }
}

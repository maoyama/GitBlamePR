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
    private var lineOnSelect: (_ lineNumber:Int) -> Void

    init(service:SourceApplicationService, lineOnSelect: @escaping (_ lineNumber:Int) -> Void){
        self.service = service
        self.lineOnSelect = lineOnSelect
    }

    var body: some View {
        SourceView(
            model: service.viewModel,
            lineOnSelect: lineOnSelect
        )
    }

}

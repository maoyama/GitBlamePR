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
    private var revisionOnHover: ((commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?)) -> Void

    init(service:SourceApplicationService, revisionOnHover: @escaping ((commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?)) -> Void){
        self.service = service
        self.revisionOnHover = revisionOnHover
    }

    var body: some View {
        SourceView(
            model: service.viewModel,
            revisionOnHover: revisionOnHover
        )
    }

}

//
//  RevisionViewWrapper.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct RevisionViewWrapper: View {
    @ObservedObject var service: RevisionApplicationService

    var body: some View {
        VStack {
            if service.viewModel.commit != nil {
                CommitView(model: service.viewModel.commit!)
            }
        }
    }
}

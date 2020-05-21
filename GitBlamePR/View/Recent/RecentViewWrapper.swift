//
//  RecentViewWrapper.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/25.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct RecentViewWrapper: View {
    @ObservedObject var service = RecentApplicationService()
    var textOnTap: (String) -> Void

    var body: some View {
        RecentView(
            model: service.viewModel,
            textOnTap: textOnTap) {
                self.service.clearHistory()
        }
    }
}

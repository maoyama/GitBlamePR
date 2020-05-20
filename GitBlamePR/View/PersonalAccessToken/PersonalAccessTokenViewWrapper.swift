//
//  PersonalAccessTokenViewWrapper.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct PersonalAccessTokenViewWrapper: View {
    @ObservedObject var service = PersonalAccessTokenApplicationService()

    var body: some View {
        PersonalAccessTokenView(
            hasToken: service.viewModel.hasToken,
            error: service.viewModel.error,
            saveButtonAction: { token in
                self.service.save(token: token)
            },
            removeButtonAction: {
                self.service.remove()
            }
        )
    }
}

//
//  PersonalAccessTokenApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

class PersonalAccessTokenApplicationService: ObservableObject {
    @Published private(set) var viewModel: PersonalAccessTokenViewModel
    private var repository: PersonalAccessTokenRepository

    init() {
        repository = PersonalAccessTokenRepository()
        do {
            if let _ = try repository.find() {
                viewModel = PersonalAccessTokenViewModel(hasToken: true)
                return
            }
            viewModel = PersonalAccessTokenViewModel(hasToken: false)
        } catch let e {
            viewModel = PersonalAccessTokenViewModel(hasToken: true, error: e.localizedDescription)
        }
    }

    func save(token: String) {
        guard let personalAccessToken = PersonalAccessToken(token)  else {
            return
        }
        do {
            try repository.save(personalAccessToken)
            viewModel = PersonalAccessTokenViewModel(hasToken: true)
        } catch let e {
            viewModel.error = e.localizedDescription
        }

    }

    func remove() {
        do {
            try repository.remove()
            viewModel = PersonalAccessTokenViewModel(hasToken: false)
        } catch let e {
            viewModel.error = e.localizedDescription
        }
    }
}

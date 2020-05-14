//
//  RecentApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/25.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

class RecentApplicationService: ObservableObject {
    @Published private(set) var viewModel: RecentViewModel
    private var historyRepository: HistoryRepository

    init() {
        self.historyRepository = HistoryRepository()
        self.viewModel = RecentViewModel(history: self.historyRepository.findAll())
    }

    func clearHistory() {
        do {
            try historyRepository.save(history: History(inputFullPaths: []))
        } catch let e {
            // TODO: error handling
            print( e.localizedDescription)
        }
        viewModel = RecentViewModel(fullPaths: [])
    }
}

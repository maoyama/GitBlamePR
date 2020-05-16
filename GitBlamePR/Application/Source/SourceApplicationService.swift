//
//  ApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/14.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

class SourceApplicationService: ObservableObject {
    @Published private(set) var viewModel: SourceViewModel
    private var historyRepository: HistoryRepository
    private var sourceRepository: SourceRepository

    init(error: String="") {
        self.historyRepository = HistoryRepository()
        self.sourceRepository = SourceRepository()
        self.viewModel = SourceViewModel(
            lines: [],
            error: error
        )
    }

    convenience init(path: String, lineNumber: Int?) {
        self.init()
        guard let path = FileFullPath(rawValue: path) else {
            viewModel = SourceViewModel(lines: [], error: "")
            return
        }
        sourceRepository.find(by: path) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let s):
                var source = s
                if let lineNumber = lineNumber, let lineNumberModel = LineNumber(lineNumber) {
                    source = source.selected(by: lineNumberModel)
                }
                self.viewModel = SourceViewModel(source: source)
                var history = self.historyRepository.findAll()
                history.addInputFullPath(path.rawValue)
                do {
                    try self.historyRepository.save(history: history)
                } catch let e {
                    self.viewModel.error = e.localizedDescription
                    return
                }
            case .failure(let e):
                self.viewModel.error = e.localizedDescription
            }
        }
    }
}

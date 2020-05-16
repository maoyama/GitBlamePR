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
    private var source: Source? {
        didSet {
            guard let source = source else {
                viewModel = SourceViewModel(
                    lines: [],
                    error: ""
                )
                return
            }
            viewModel = SourceViewModel(source: source)
        }
    }

    init(error: String="") {
        self.historyRepository = HistoryRepository()
        self.sourceRepository = SourceRepository()
        self.viewModel = SourceViewModel(
            lines: [],
            error: error
        )
    }

    convenience init(path: String) {
        self.init()
        guard let path = FileFullPath(rawValue: path) else {
            return
        }
        pathDidCommit(path: path)
    }

    func lineDidSelect(lineNumber: Int) {
        guard let number = LineNumber(lineNumber) else {
            return
        }
        guard let selected = source?.selected(by: number) else {
            return
        }
        source = selected
    }

    private func pathDidCommit(path: FileFullPath) {
        sourceRepository.find(by: path) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let source):
                self.source = source
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

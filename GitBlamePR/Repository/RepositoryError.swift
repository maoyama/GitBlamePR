//
//  RepositoryError.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct RepositoryError: Error, LocalizedError {
    static var unknown = RepositoryError(description: "Unknown error.")

    private var description: String
    var errorDescription: String? {
        return description
    }

    init(description: String) {
        self.description = description
    }
}

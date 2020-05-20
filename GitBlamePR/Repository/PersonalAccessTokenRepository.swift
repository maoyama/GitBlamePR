//
//  PersonalAccessTokenRepository.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation
import KeychainAccess

struct PersonalAccessTokenRepository {
    private let db = Keychain()
    private let key = "PrivateAccessToken"

    func find() throws  -> PersonalAccessToken {
        guard let raw = try db.get(key) else {
            throw RepositoryError.unknown
        }
        guard let token = PersonalAccessToken(raw) else {
            throw RepositoryError.unknown
        }
        return token
    }

    func save(_ token: PersonalAccessToken) throws {
        try db.set(token.rawValue, key: key)
    }

    func remove() throws {
        try db.remove(key)
    }
}

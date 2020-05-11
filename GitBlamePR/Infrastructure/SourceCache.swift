//
//  SourceCache.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/10.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

class SourceCache {
    static let shared = SourceCache()
    private let cache = NSCache<NSString, AnyObject>()

    func set(_ source: Source, forKey path: FileFullPath) {
        cache.setObject(source as AnyObject, forKey: path.rawValue as NSString)
    }

    func object(forKey path: FileFullPath) -> Source? {
        if let obj = cache.object(forKey: path.rawValue as NSString) as? Source {
            return obj
        }
        return nil
    }
}

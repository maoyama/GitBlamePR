//
//  Session+send.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/19.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation
import APIKit

extension Session {
    class func send<Request: APIKit.Request>(_ request: Request, handler: @escaping (Result<Request.Response, RepositoryError>) -> Void)  {
        Self.send(request, callbackQueue: nil) { (result) in
            let new = result.mapError { (error) -> RepositoryError in
                RepositoryError(description: error.localizedDescription)
            }
            handler(new)
        }
    }
}

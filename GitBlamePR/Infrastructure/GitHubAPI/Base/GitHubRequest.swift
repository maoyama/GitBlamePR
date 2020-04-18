//
//  GitHubRequest.swift
//  Airfield
//
//  Created by Makoto Aoyama on 2019/08/28.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation
import APIKit

protocol GitHubRequest: Request {}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

extension JSONDecoder {
    static func makeGitHubJSONDecoder() -> JSONDecoder {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        d.dateDecodingStrategy = .iso8601
        return d
    }
}

extension GitHubRequest where Response: Decodable {
    var decoder: JSONDecoder {
        return JSONDecoder.makeGitHubJSONDecoder()
    }

    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }

        return try decoder.decode(Response.self, from: data)
    }
}

protocol PagingGitHubRequest: GitHubRequest {
    var page: Int { get set }
}

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

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard 200..<300 ~= urlResponse.statusCode else {
            throw GitHubAPIError(statusCode: urlResponse.statusCode, object: object)
        }
        return object
    }
}

struct GitHubAPIError: Error {
    var statusCode: Int
    var message: String

    init(statusCode: Int, object: Any) {
        self.statusCode = statusCode
        guard
            let json = object as? Data,
            let response = try? JSONDecoder().decode(Responce.self, from: json),
            let responseMsg = response.message
        else {
            message = "Unknown error."
            return
        }
        message = responseMsg
    }

    private struct Responce: Decodable {
        var message: String?
    }
}

protocol PagingGitHubRequest: GitHubRequest {
    var page: Int { get set }
}

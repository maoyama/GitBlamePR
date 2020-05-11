//
//  DecodableDataParser.swift
//  Airfield
//
//  Created by Makoto Aoyama on 2019/08/28.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}

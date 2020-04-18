//
//  PageNumber.swift
//  Airfield
//
//  Created by Makoto Aoyama on 2019/11/16.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

struct PageNumber {
    static var first: PageNumber {
        PageNumber(value: 1)!
    }

    private (set) var value: Int

    init?(value: Int) {
        guard value > 0 else { return nil } // page numbering is 1-based
        self.value = value
    }

    var next: PageNumber {
        PageNumber(value: value + 1)!
    }

    var prev: PageNumber? {
        PageNumber(value: value - 1)
    }
}

//
//  Example.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 8/25/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import Foundation

struct Example: Equatable {
    var name: String
    var id: Int
}

func ==(lhs: Example, rhs: Example) -> Bool {
    return lhs.name == rhs.name
        && lhs.id == rhs.id
}

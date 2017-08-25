//
//  Post.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 8/25/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import Foundation
import IGListKit

struct Post: Equatable {
    let username: String
    let comments: [String]
    let photoURL: String
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.username == rhs.username
        && lhs.comments == rhs.comments
        && lhs.photoURL == rhs.photoURL
}


//
//  Tumblr.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/12/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo: Equatable {
    var url: String
    var originalWidth: Int
    var originalHeight: Int
    
    init(json: JSON) {
        url = json["original_size"]["url"].stringValue
        originalWidth = json["original_size"]["width"].intValue
        originalHeight = json["original_size"]["height"].intValue
    }
}

struct TumblrPost {
    var blogId: Int
    var blogName: String
    var photos: [Photo]
    
    init(json: JSON) {
        blogId = json["id"].intValue
        blogName = json["blog_name"].stringValue
        photos = json["photos"].arrayValue.map { Photo(json: $0) }
    }
}

func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.url == rhs.url
        && lhs.originalWidth == rhs.originalWidth
        && lhs.originalHeight == rhs.originalHeight
}



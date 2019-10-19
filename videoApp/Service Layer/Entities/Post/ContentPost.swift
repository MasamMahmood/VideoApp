//
//  ContentPost.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Unbox

class ContentPost: Post, IContentPost {
    let thumbnailUrl: String?
    let postUrl: String
    let commentsCount: Int
    let views: Int
    let likes: Int
    let shares: Int
    
    required init(unboxer: Unboxer) throws {
        thumbnailUrl = try unboxer.unbox(key: "thumbnailUrl")
        postUrl = try unboxer.unbox(key: "postUrl")
        commentsCount = try unboxer.unbox(key: "commentsCount")
        views = try unboxer.unbox(key: "views")
        likes = try unboxer.unbox(key: "likes")
        shares = try unboxer.unbox(key: "shares")
        try super.init(unboxer: unboxer)
    }
}


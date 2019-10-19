//
//  PostsService.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class PostsService: BasicService, IPostsService {
    
    func getPosts(userId: String?, startingId: String?, afterId: String?, pageSize: String) {
        
    }
    
//    Posts endpoint:
//    https://api.whatsviralapp.com/v2/posts
//
//    Gives list of newest post (order by date creation desc). Newest post comes first.
//
//    Request
//    ?userId= - will be REQUIRED soon! uuid of user
//    ?pageSize=5 - show first 5 result (default 10)
//
//    ?afterPostId=1234 - show elements after post with 1234 (NOT including 1234 itself) - used in feed requesting
//
//    ?startingPostId=1234 - show elements starting post with 1234 (INCLUDING 1234 itself) - used in shared post display
//
//    Result
//    JSON
//
//    Items [] -resulting list
//
//    Count -number of posts returned
//
//    LastEvaluatedKey - last post in Items (?? do we even need this)
}

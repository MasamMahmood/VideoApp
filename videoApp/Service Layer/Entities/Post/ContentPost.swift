//
//  ContentPost.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

class ContentPost: Post, IContentPost {
    var thumbnailUrl: String? = nil
    var postUrl: String = ""
    var commentsCount: Int = 0
    var views: Int = 0
    var likes: Int = 0
    var shares: Int = 0
    
    required init(dic: [String : Any]) {
        if let postUrl = dic["postUrl"] as? String,
            let commentsCount = dic["comments"] as? Int,
            let views = dic["views"] as? Int,
            let likes = dic["likes"] as? Int,
            let shares = dic["shares"] as? Int {
            self.postUrl = postUrl
            self.commentsCount = commentsCount
            self.views = views
            self.likes = likes
            self.shares = shares
            self.thumbnailUrl = dic["thumbnailUrl"] as? String
        }
        super.init(dic: dic)
    }
}

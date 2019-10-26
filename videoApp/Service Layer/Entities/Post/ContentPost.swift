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
        if let postUrl = dic["postUrl"] as? String {
            self.postUrl = postUrl
            self.commentsCount = dic["comments"] as? Int ?? 0
            self.views = dic["views"] as? Int ?? 0
            self.likes = dic["likes"] as? Int ?? 0
            self.thumbnailUrl = dic["thumbnailUrl"] as? String
            self.shares = dic["shares"] as? Int ?? 0
        }
        super.init(dic: dic)
    }
}

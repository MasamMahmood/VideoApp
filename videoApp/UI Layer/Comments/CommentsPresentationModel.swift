//
//  CommentsPresentationModel.swift
//  videoApp
//
//  Created by Olga Vorona on 09/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class CommentsPresentationModel: CommentsViewOutput {
    
    var view: CommentsViewInput
    var service: IPostsService
    
    init(view: CommentsViewInput,
         service: IPostsService) {
        self.view = view
        self.service = service
    }
    
    func postLiked(postId: String) {
        service.likePost(userId: "niltest", postId: postId)
    }
    
    func postShared(postId: String) {
        service.sharePost(userId: "niltest", postId: postId)
    }
    
    func postViewed(postId: String) {
        service.viewPost(userId: "niltest", postId: postId)
    }
}

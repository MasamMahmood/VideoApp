//
//  CommentsPresentationModel.swift
//  videoApp
//
//  Created by Olga Vorona on 09/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class CommentsPresentationModel: CommentsViewOutput {
    
    private weak var view: CommentsViewInput?
    private weak var post: IContentPost?
    private let service: IPostsService = ServiceProvider.instance.postService
    private let commentService: ICommentsService = ServiceProvider.instance.commentsService
    
    init(view: CommentsViewInput,
         post: IContentPost) {
        self.view = view
        self.post = post
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
    
    func commentSent(text: String) {
        
    }
    
    func getComments(completion: (([IComment]?) -> Void)?) {
        commentService.getComments(postId: post!.id, completion: completion)
    }
}

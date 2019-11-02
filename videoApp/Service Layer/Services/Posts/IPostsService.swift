//
//  IPostsService.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol IPostsService {
    func getPosts(userId: String,
                  startingId: String?,
                  afterId: String?,
                  pageSize: String,
                  completion: @escaping (([IPost]?) -> Void))
    func cancelGet()
    func likePost(userId: String, postId: String)
    func viewPost(userId: String, postId: String)
    func sharePost(userId: String, postId: String)
}

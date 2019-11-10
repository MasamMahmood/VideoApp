//
//  CommentsViewProtocol.swift
//  videoApp
//
//  Created by Olga Vorona on 09/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol CommentsViewInput: class {
}

protocol CommentsViewOutput: class {
    func postLiked(postId: String)
    func postShared(postId: String)
    func postViewed(postId: String)
    func commentSent(text: String)
    func getComments(completion: (([IComment]?) -> Void)?)
}

//
//  ICommentsService.swift
//  videoApp
//
//  Created by Olga Vorona on 10/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol ICommentsService {
    func getComments(postId: String,
                  completion: (([IComment]?) -> Void)?)
    func writeComment(userId: String, postId: String, comment: String)
}


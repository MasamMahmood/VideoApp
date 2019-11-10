//
//  Comment.swift
//  videoApp
//
//  Created by Olga Vorona on 10/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

class Comment: IComment {
    var id: String = ""
    var comment: String = ""
    var userId: String = ""
    var postId: String = ""
    var timestamp: Int = 0
    var createAt: Date = Date()
    
    required init(dic: [String : Any]) {
        if let id = dic["id"] as? String,
            let comment = dic["comment"] as? String,
            let userId = dic["userId"] as? String,
            let postId = dic["postId"] as? String,
            let timestamp = dic["timestamp"] as? Int {
            self.id = id
            self.comment = comment
            self.userId = userId
            self.postId = postId
            self.timestamp = timestamp
            self.createAt = Date(timeIntervalSince1970: TimeInterval(timestamp/1000))
        }
    }
}

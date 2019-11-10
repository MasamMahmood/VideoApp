//
//  Post.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class Post: IPost {
    var id: String = ""
    var title: String = ""
    var type: String = ""
    var width: Int = 0
    var height: Int = 0
    var createAt: Date = Date()
    
    required init(dic: [String : Any]) {
        if let id = dic["id"] as? String,
            let title = dic["title"] as? String,
            let type = dic["type"] as? String,
            let width = dic["width"] as? Int,
            let height = dic["height"] as? Int {
            self.id = id
            self.title = title
            self.type = type
            self.width = width
            self.height = height
            if let dateString = dic["created_at"] as? Int {
                self.createAt = Date(timeIntervalSince1970: TimeInterval(dateString/1000))
            }
        }
    }
}

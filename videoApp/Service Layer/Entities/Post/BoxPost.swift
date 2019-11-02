//
//  BoxPost.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class BoxPost: Post, IBoxPost {
    var thumbnailUrl: String = ""
    var animationUrl: String = ""
    var status: String = ""
    var code: String? = ""
    var prizeUrl: String? = ""
    var prizeType: String? = ""
    
    required init(dic: [String : Any]) {
        if let animationUrl = dic["animationUrl"] as? String,
            let thumbnailUrl = dic["thumbnailUrl"] as? String,
            let status = dic["status"] as? String {
            self.animationUrl = animationUrl
            self.thumbnailUrl = thumbnailUrl
            self.status = status
            self.code = dic["code"] as? String
            self.prizeUrl = dic["prizeUrl"] as? String
            self.prizeType = dic["prizeType"] as? String
        }
        super.init(dic: dic)
    }
    
}

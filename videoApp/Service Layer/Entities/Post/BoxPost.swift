//
//  BoxPost.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Unbox

class BoxPost: Post, IBoxPost {
    let thumbnailUrl: String
    let animationUrl: String
    let status: String
    let code: String
    let prizeUrl: String
    let prizeType: String
    
    required init(unboxer: Unboxer) throws {
        thumbnailUrl = try unboxer.unbox(key: "thumbnailUrl")
        animationUrl = try unboxer.unbox(key: "animationUrl")
        status = try unboxer.unbox(key: "status")
        code = try unboxer.unbox(key: "code")
        prizeUrl = try unboxer.unbox(key: "prizeUrl")
        prizeType = try unboxer.unbox(key: "prizeType")
        try super.init(unboxer: unboxer)    }
}

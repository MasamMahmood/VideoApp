//
//  Post.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Unbox

class Post: IPost, Unboxable {
    let id: String
    let title: String
    let type: String
    let width: Int
    let height: Int
    let createAt: Date
    
    required init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        title = try unboxer.unbox(key: "title")
        type = try unboxer.unbox(key: "type")
        width = try unboxer.unbox(key: "width")
        height = try unboxer.unbox(key: "height")
        let dateString: String = try unboxer.unbox(key: "createAt")
        createAt = Date()
    }
}

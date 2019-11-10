//
//  IContentPost.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol IContentPost: class, IPost {
    var thumbnailUrl: String? { get }
    var postUrl: String { get }
    var commentsCount: Int { get }
    var views: Int { get }
    var likes: Int { get }
    var shares: Int { get }
}

//
//  IComment.swift
//  videoApp
//
//  Created by Olga Vorona on 10/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol IComment {
    var id: String { get }
    var comment: String { get }
    var userId: String { get }
    var postId: String { get }
    var timestamp: Int { get }
    var createAt: Date { get }
}

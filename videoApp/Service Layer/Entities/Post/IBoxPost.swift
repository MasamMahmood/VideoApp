//
//  IBoxPost.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol IBoxPost: IPost {
    var thumbnailUrl: String { get }
    var animationUrl: String { get }
    var status: String { get }
    var code: String? { get }
    var prizeUrl: String? { get }
    var prizeType: String? { get }
}

//
//  FeedFeedViewProtocols.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

import UIKit

protocol FeedViewInput: class {
    var output: FeedViewOutput? { get set }
    func feedRecieved(posts: [IPost], indexPathToReload: [IndexPath]?)
    func showShare(text: String)
}

protocol FeedViewOutput: class {
    func feedRequested()
    func refreshRequested()
    func postLiked(postId: String)
    func postShared(postId: String)
    func postViewed(postId: String)
}

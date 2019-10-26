//
//  FeedFeedViewProtocols.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

import UIKit

protocol FeedViewInput: class {
    var currentController: UIViewController { get }
    var rootNavigationController: UINavigationController? { get }
    var output: FeedViewOutput? { get set }
    func feedRecieved(posts: [IPost], indexPathToReload: [IndexPath]?)
}

protocol FeedViewOutput: class {
    func feedRequested()
}

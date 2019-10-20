//
//  FeedFeedPresenterProtocols.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

protocol FeedPresentationModelInterface: class {
    var view: FeedViewInput { get }
    var service: IPostsService { get }
}

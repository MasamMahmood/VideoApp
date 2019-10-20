//
//  FeedFeedPresenter.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

// MARK: - Stored Properties

class FeedPresentationModel: FeedPresentationModelInterface {
    var view: FeedViewInput
    var service: IPostsService
    
    init(view: FeedViewInput, service: IPostsService) {
        self.view = view
        self.service = service
    }
}

// MARK: - FeedViewOutput Implementation

extension FeedPresentationModel: FeedViewOutput {
    func feedRequested(completion: @escaping(([IPost] )-> Void)) {
        service.getPosts(userId: nil, startingId: nil, afterId: nil, pageSize: "20") { (posts) in
            completion(posts)
        }
    }

}

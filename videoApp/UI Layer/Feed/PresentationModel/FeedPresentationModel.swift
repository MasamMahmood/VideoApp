//
//  FeedFeedPresenter.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

// MARK: - Stored Properties
import Foundation

class FeedPresentationModel: FeedPresentationModelInterface {
    var view: FeedViewInput
    var service: IPostsService
    private var loadInProgress: Bool = false
    private var lastId: String? = nil
    private let pageSize = 20
    private var posts: [IPost] = []
    init(view: FeedViewInput, service: IPostsService) {
        self.view = view
        self.service = service
    }
    
    private func calculateIndexPathsToReload(from newPosts: [IPost]) -> [IndexPath] {
        let startIndex = posts.count - newPosts.count
        let endIndex = startIndex + newPosts.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    private func newPostsRecieved(new: [IPost]) {
        posts.append(contentsOf: new)
        var indexes: [IndexPath]? = nil
        if posts.count != new.count {
            indexes = calculateIndexPathsToReload(from: new)
        }
        view.feedRecieved(posts: posts, indexPathToReload: indexes)
    }
}

// MARK: - FeedViewOutput Implementation

extension FeedPresentationModel: FeedViewOutput {
    func feedRequested() {
        guard !loadInProgress else { return }
        loadInProgress = true
        service.getPosts(userId: nil, startingId: nil, afterId: lastId, pageSize: "\(pageSize)") {[weak self] (newPosts) in
            self?.loadInProgress = false
            if let newPosts = newPosts {
                self?.lastId = newPosts.last?.id
                DispatchQueue.main.async { [weak self] in 
                    self?.newPostsRecieved(new: newPosts)
                }
            }
        }
    }

}

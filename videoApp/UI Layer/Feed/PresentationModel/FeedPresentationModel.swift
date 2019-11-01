//
//  FeedFeedPresenter.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

// MARK: - Stored Properties
import Foundation

final class FeedPresentationModel: FeedPresentationModelInterface {
   
    internal var view: FeedViewInput
    internal var service: IPostsService

    private var loadInProgress: Bool = false
    private var pullInProgress: Bool = false

    private var lastId: String? = nil
    private let pageSize = 20
    private var posts: [IPost] = []
    
    init(view: FeedViewInput,
         service: IPostsService) {
        self.view = view
        self.service = service
    }
    
    private func calculateIndexPathsToReload(from newPosts: [IPost]) -> [IndexPath] {
        let startIndex = posts.count - newPosts.count
        let endIndex = startIndex + newPosts.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func bottomPostsRecieved(new: [IPost]) {
        posts.append(contentsOf: new)
        var indexes: [IndexPath]? = nil
        if posts.count != new.count {
            indexes = calculateIndexPathsToReload(from: new)
        }
        view.feedRecieved(posts: posts, indexPathToReload: indexes)
    }
    
    private func topPostsRecieved(new: [IPost]) {
        posts = new
        view.feedRecieved(posts: posts, indexPathToReload: nil)
    }}

// MARK: - FeedViewOutput Implementation

extension FeedPresentationModel: FeedViewOutput {
    func feedRequested() {
        guard !loadInProgress, !pullInProgress else { return }
        loadInProgress = true
        service.getPosts(userId: "niltest", startingId: nil, afterId: lastId, pageSize: "\(pageSize)") {[weak self] (newPosts) in
            self?.loadInProgress = false
            if let newPosts = newPosts {
                self?.lastId = newPosts.last?.id
                DispatchQueue.main.async { [weak self] in 
                    self?.bottomPostsRecieved(new: newPosts)
                }
            }
        }
    }
    
    func refreshRequested() {
        if loadInProgress {
            service.cancelGet()
            loadInProgress = false
        }
        
        service.getPosts(userId: "niltest", startingId: nil, afterId: nil, pageSize: "\(pageSize)") {[weak self] (newPosts) in
            self?.loadInProgress = false
            if let newPosts = newPosts {
                self?.lastId = newPosts.last?.id
                DispatchQueue.main.async { [weak self] in
                    self?.topPostsRecieved(new: newPosts)
                }
            }
        }
    }
    
    func postLiked(postId: String) {
        service.likePost(userId: "niltest", postId: postId)
    }
    
    func postShared(postId: String) {
        service.sharePost(userId: "niltest", postId: postId)
        let text = "Hey! You gotta see that! 😂🤣 https://lols.link/share?\(postId)"
        view.showShare(text: text)
    }
    
    func postViewed(postId: String) {
        service.viewPost(userId: "niltest", postId: postId)
    }

}

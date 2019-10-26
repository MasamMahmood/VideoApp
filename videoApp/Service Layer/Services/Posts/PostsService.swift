//
//  PostsService.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class PostsService: BasicService, IPostsService {
    enum PostType: String {
        case video
        case ad
        
    }
    func getPosts(userId: String?,
                  startingId: String?,
                  afterId: String?,
                  pageSize: String,
                  completion:@escaping (([IPost]?) -> Void)) {
        let urlString = basicURL + Endpoints.posts.rawValue
        let url: URL! = URL(string: urlString)
        var params = ["userId": UUID().uuidString, "pageSize": pageSize] as [String : Any]
        if let afterId = afterId {
            params["afterPostId"] = afterId
        }
        if let startingId = startingId {
            params["startingPostId"] = startingId
        }
        let request = sessionManager.request(url, method: .get, parameters: params)
        request.responseJSON { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let data):
                guard let result = data as? [String: Any],
                    let obj = result["Items"] as? [[String: Any]] else {
                        completion([])
                        return
                }
                var posts:[IPost] = []
                for post in obj {
                    if let post = self.parsePost(from: post) {
                        posts.append(post)
                    }
                }
                completion(posts)
            case .failure(_):
                completion([])
            }
        }
        request.resume()
    }
    
    private func parsePost(from dic: [String: Any]) -> IPost? {
        guard let type = dic["type"] as? String,
        let value = PostType(rawValue: type) else { return nil }
        let result: IPost?
        switch value {
        case .ad:
            result = Post(dic: dic)
        case .video:
            result = ContentPost(dic: dic)
        }
        return result
    }
    
//    Posts endpoint:
//    https://api.whatsviralapp.com/v2/posts
//
//    Gives list of newest post (order by date creation desc). Newest post comes first.
//
//    Request
//    ?userId= - will be REQUIRED soon! uuid of user
//    ?pageSize=5 - show first 5 result (default 10)
//
//    ?afterPostId=1234 - show elements after post with 1234 (NOT including 1234 itself) - used in feed requesting
//
//    ?startingPostId=1234 - show elements starting post with 1234 (INCLUDING 1234 itself) - used in shared post display
//
//    Result
//    JSON
//
//    Items [] -resulting list
//
//    Count -number of posts returned
//
//    LastEvaluatedKey - last post in Items (?? do we even need this)
}

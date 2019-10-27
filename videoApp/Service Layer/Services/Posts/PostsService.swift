//
//  PostsService.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Alamofire

class PostsService: BasicService, IPostsService {
   
    enum PostType: String {
        case video
        case ad
        case box
    }
    private weak var getRequest: DataRequest? = nil
    
    func likePost(userId: String, postId: String) {
        let urlString = basicURL + Endpoints.likes.rawValue + "/add"
        let url: URL! = URL(string: urlString)
        let params = ["userId": userId, "postId": postId] as [String : Any]
        let request = sessionManager.request(url, method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default)

        request.log().responseJSON {(response) in
            switch response.result {
            case .success(_):
                print("success likes")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        request.resume()
    }
    
    func getPosts(userId: String,
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
        getRequest = request
    }
    
    func cancelGet() {
        getRequest?.cancel()
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
          case .box:
              result = BoxPost(dic: dic)
          }
          return result
      }
}

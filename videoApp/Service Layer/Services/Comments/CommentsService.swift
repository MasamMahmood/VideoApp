//
//  CommentsService.swift
//  videoApp
//
//  Created by Olga Vorona on 10/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Alamofire

class CommentsService: BasicService, ICommentsService {

    func writeComment(userId: String, postId: String, comment: String) {
        let urlString = basicURL + Endpoints.comments.rawValue + "/add"
        let url: URL! = URL(string: urlString)
        let params = ["userId": userId, "postId": postId, "comment": comment] as [String : Any]
        let request = sessionManager.request(url, method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default)

        request.log().responseJSON {(response) in
            switch response.result {
            case .success(_):
                print("success shares")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        request.resume()
    }
    
    func getComments(postId: String,
                  completion: (([IComment]?) -> Void)?) {
        let urlString = basicURL + Endpoints.comments.rawValue
        let url: URL! = URL(string: urlString)
        let params = ["postId": postId] as [String : Any]
        let request = sessionManager.request(url, method: .get, parameters: params)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let result = data as? [String: Any],
                    let obj = result["Items"] as? [[String: Any]] else {
                        completion?([])
                        return
                }
                var comments = [IComment]()
                for dic in obj {
                    comments.append(Comment(dic: dic))
                }
                completion?(comments)
            case .failure(_):
                completion?([])
            }
        }
        request.resume()
    }
}

//[["timestamp": 1573286113381, "postId": k2pwvl3j, "userId": debug_user, "comment": kgggg, "id": 77560c1e-1ad3-4912-a625-b343afe6d18e], ["timestamp": 1573286135463, "postId": k2pwvl3j, "comment": wow, "id": 9e2858d2-5f20-4889-ae9e-fb800f308ba4, "userId": debug_user]]
//List
//https://api.whatsviralapp.com/v2/comments?postId=456 show list of comments. no pagination for now, will add later if needed
//
//send
//https://api.whatsviralapp.com/v2/comments/add POST json { "userId":"123", "postId":"456", "comment":"my comment goes here" }
//
//count

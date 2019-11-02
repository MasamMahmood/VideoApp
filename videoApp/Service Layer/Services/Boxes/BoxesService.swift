//
//  BoxesServices.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Alamofire

class BoxesService: BasicService, IBoxesService {
    func getBoxes(userId: String, completion: @escaping (([IBoxPost]?) -> Void)) {
        let urlString = basicURL + Endpoints.boxes.rawValue
        let url: URL! = URL(string: urlString)
        let params = ["userId": userId] as [String : Any]
        let request = sessionManager.request(url, method: .get, parameters: params)
        request.responseJSON {(response) in
            switch response.result {
            case .success(let data):
                guard let result = data as? [String: Any],
                    let obj = result["Items"] as? [[String: Any]] else { return }
                var posts:[IBoxPost] = []
                for post in obj {
                    posts.append(BoxPost(dic: post))
                }
                completion(posts)
                print(obj)
            case .failure(_):
                print("failure")
                completion(nil)
            }
        }
        request.resume()
    }
}
//"animationUrl":      https:      //media-cont.s3-us-west-1.amazonaws.com/feed/unboxing_win3.mp4,
//"width":      556,
//"status":      created,
//"height":      514,
//"title":      Open me! I am your reward!,
//"type":      box,
//"id":      7b07650e-ac6b-4482-93a6-d248d02086f1,
//"thumbnailUrl":      https:      //media-cont.s3-us-west-1.amazonaws.com/feed/giftbox3.gif,
//"created_at":      1572691202532

//Boxes(rewards) endpoint:
//https://api.whatsviralapp.com/v2/boxes?userId=123
//
//returns list of boxes for this user.
//
//Request
//?userId= uuid of user - REQUIRED
//
//https://api.whatsviralapp.com/v2/boxes?userId=123&boxId=456&action=show
//
//show box boxId
//
//Request
//?userId= uuid of user - REQUIRED ?boxId= uuid of box - REQUIRED
//
//https://api.whatsviralapp.com/v2/boxes?userId=123&boxId=456&action=open
//
//open box boxId
//
//Request
//?userId= uuid of user - REQUIRED ?boxId= uuid of box - REQUIRED
//
//https://api.whatsviralapp.com/v2/boxes?userId=123&action=count&type=created
//
//count number of boxes of given type
//
//Request
//?userId= uuid of user - REQUIRED type = created =unopen; opened = opened
//companion object {
//    private const val EMPTY_VIEW_TYPE = -1
//    private const val CREATED_BOX_VIEW_TYPE = 0
//    private const val GIFT_BOX_VIEW_TYPE = 1
//    private const val IMAGE_BOX_VIEW_TYPE = 2
//}

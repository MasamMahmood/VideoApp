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
            case .failure(_):
                print("failure")
                completion(nil)
            }
        }
        request.resume()
    }
    
    func openBox(userId: String, boxId: String, completion: @escaping ((IBoxPost?) -> Void)) {
        let urlString = basicURL + Endpoints.boxes.rawValue
        let url: URL! = URL(string: urlString)
        let params = ["userId": userId, "boxId": boxId, "action": "open"] as [String : Any]
        let request = sessionManager.request(url, method: .get,
                                             parameters: params)

        request.log().responseJSON {(response) in
            switch response.result {
            case .success(let data):
                guard let result = data as? [String: Any],
                let obj = result["Item"] as? [String: Any] else { return }
                completion(BoxPost(dic: obj))
                print("success open")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        request.resume()
    }
}

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

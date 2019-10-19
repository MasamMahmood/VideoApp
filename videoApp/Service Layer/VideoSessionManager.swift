//
//  VideoSessionManager.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Alamofire

class PlatoonSessionManager: SessionManager {
    override func request(_ url: URLConvertible,
                          method: HTTPMethod = .get,
                          parameters: Parameters? = nil,
                          encoding: ParameterEncoding = URLEncoding.default,
                          headers: HTTPHeaders? = nil) -> DataRequest {
        return super.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                    .validate(statusCode: 200...300)
    }
    
    override func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return super.request(urlRequest).validate(statusCode: 200...300)
    }
}

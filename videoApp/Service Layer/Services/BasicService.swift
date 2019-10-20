//
//  BasicService.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Alamofire

class BasicService {
    static let basicURL = "https://api.whatsviralapp.com/v2/"
    enum Endpoints: String {
        case posts
        case boxes
        case comments
        case views
        case likes
        case shares
    }
    private let networking: ServiceProvider

    var sessionManager: SessionManager {
        return networking.sessionManager
    }

    var sessionManagerCache: SessionManager {
        return networking.sessionManagerCache
    }

    // MARK: - Memory managment

    required public init(networking: ServiceProvider) {
        self.networking = networking
    }
    
}
 


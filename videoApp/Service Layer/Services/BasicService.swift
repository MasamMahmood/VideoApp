//
//  BasicService.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Alamofire

class BasicService {
    let basicURL = "https://api.whatsviralapp.com/v2/"
    enum Endpoints: String {
        case posts
        case boxes
        case comments
        case views
        case likes
        case shares
    }
    let sessionManager: SessionManager

    // MARK: - Memory managment

    required public init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
}
 


//
//  ServiceProvider.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Alamofire

class ServiceProvider {
   
    private struct Consts {
        
        static let memorySpaceMB = 100
        static let memoryCapacity = memorySpaceMB * 1024 * 1024
        
        static let diskSpaceMB = 300
        static let diskCapacity = diskSpaceMB * 1024 * 1024
        
    }
    
    static let basicURL = "https://api.whatsviralapp.com/v2/"
   
    enum Endpoints: String {
        case posts
        case boxes
        case comments
        case views
        case likes
        case shares
    }
    
    // MARK: - Properties
    
    
//    private let configuration: URLSessionConfiguration
//    public let sessionManager: SessionManager
//
//    private let configurationCache: URLSessionConfiguration
//    public let sessionManagerCache: SessionManager
    
    // MARK: - Memory managments
    
//    public init()  {
        
        
//        // SessionManager without cache
//        configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = defaultHTTPTimeoutInterval
//
//        sessionManager = PlatoonSessionManager(configuration: configuration)
//        accessTokenAdapter = AccessTokenAdapter(storageService: storageService)
//
//        sessionManager.adapter = accessTokenAdapter
//
//        // SessionManager with cache
//        configurationCache = URLSessionConfiguration.default
//        configurationCache.timeoutIntervalForRequest = defaultHTTPTimeoutInterval
//
//        configurationCache.requestCachePolicy = .returnCacheDataElseLoad
//        configurationCache.urlCache = URLCache(memoryCapacity: Consts.memoryCapacity,
//                                          diskCapacity: Consts.diskCapacity,
//                                          diskPath: "Alamofire_cache")
//
//        sessionManagerCache = PlatoonSessionManager(configuration: configurationCache)
//        sessionManagerCache.adapter = accessTokenAdapter
//    }
}


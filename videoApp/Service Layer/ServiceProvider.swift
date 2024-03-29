//
//  ServiceProvider.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Alamofire

final class ServiceProvider {
    static let instance = ServiceProvider()
    
    private struct Consts {
        static let memorySpaceMB = 100
        static let memoryCapacity = memorySpaceMB * 1024 * 1024
        static let diskSpaceMB = 300
        static let diskCapacity = diskSpaceMB * 1024 * 1024
        static let defaultHTTPTimeoutInterval: TimeInterval = 20
    }

    public let postService: IPostsService
    public let boxService: IBoxesService
    public let commentsService: ICommentsService

    // MARK: - Properties
    
    private let sessionManager: SessionManager
    private let sessionManagerCache: SessionManager
    private let configuration: URLSessionConfiguration
    private let configurationCache: URLSessionConfiguration
    
    // MARK: - Memory managments
    
    public init()  {
        
        // SessionManager without cache
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Consts.defaultHTTPTimeoutInterval
        sessionManager = VideoSessionManager(configuration: configuration)
        
        // SessionManager with cache
        configurationCache = URLSessionConfiguration.default
        configurationCache.timeoutIntervalForRequest = Consts.defaultHTTPTimeoutInterval
        configurationCache.requestCachePolicy = .returnCacheDataElseLoad
        configurationCache.urlCache = URLCache(memoryCapacity: Consts.memoryCapacity,
                                          diskCapacity: Consts.diskCapacity,
                                          diskPath: "Alamofire_cache")
        sessionManagerCache = VideoSessionManager(configuration: configurationCache)
        
        postService = PostsService(sessionManager: sessionManager)
        boxService = BoxesService(sessionManager: sessionManager)
        commentsService = CommentsService(sessionManager: sessionManager)
    }
}


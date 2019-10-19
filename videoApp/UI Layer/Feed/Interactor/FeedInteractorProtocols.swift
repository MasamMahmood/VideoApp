//
//  FeedFeedInteractorProtocols.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

protocol FeedInteractorInput: class {
    var output: FeedInteractorOutput? { get set }
}

protocol FeedInteractorOutput: class {
    func error(code: Int)
}

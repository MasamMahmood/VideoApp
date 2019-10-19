//
//  FeedFeedPresenterProtocols.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

protocol FeedPresenterInterface: class {
    var interactor: FeedInteractorInput? { get set }
    var view: FeedViewInput? { get set }
}

protocol FeedPresenterDelegate: class {
}

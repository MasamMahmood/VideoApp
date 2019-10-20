//
//  FeedFeedPresenter.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

// MARK: - Stored Properties

class FeedPresentationModel {
    private weak var viewInput: FeedViewInput?
}

// MARK: - FeedPresenterInterface Implementation

extension FeedPresentationModel: FeedPresentationModelInterface {
    // MARK: Structural Computed Properties

    
    var view: FeedViewInput? {
        get {
            return viewInput
        }
        set {
            viewInput = newValue
        }
    }

}


// MARK: - FeedViewOutput Implementation

extension FeedPresentationModel: FeedViewOutput {
    func viewDestroyed() {
        
    }
}

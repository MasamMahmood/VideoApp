//
//  FeedFeedInteractor.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

// MARK: - Stored Properties

class FeedInteractor {
    private weak var interactorOutput: FeedInteractorOutput?
}

// MARK: - FeedInteractorInput Implementation

extension FeedInteractor: FeedInteractorInput {
    // MARK: Structural Computed Properties
    var output: FeedInteractorOutput? {
        get {
            return interactorOutput
        }
        set {
            interactorOutput = newValue
        }
    }
}

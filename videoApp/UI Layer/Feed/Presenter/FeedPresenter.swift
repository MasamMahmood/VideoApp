//
//  FeedFeedPresenter.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

// MARK: - Stored Properties

class FeedPresenter {
    private var interactorInput: FeedInteractorInput?
    private weak var viewInput: FeedViewInput?
    private weak var presenterDelegate: FeedPresenterDelegate?
}

// MARK: - FeedPresenterInterface Implementation

extension FeedPresenter: FeedPresenterInterface {
    // MARK: Structural Computed Properties
    var interactor: FeedInteractorInput? {
        get {
            return interactorInput
        }
        set {
            interactorInput = newValue
        }
    }
    
    var view: FeedViewInput? {
        get {
            return viewInput
        }
        set {
            viewInput = newValue
        }
    }
    
    var delegate: FeedPresenterDelegate? {
        get {
            return presenterDelegate
        }
        set {
            presenterDelegate = newValue
        }
    }
}

// MARK: - FeedInteractorOutput Implementation

extension FeedPresenter: FeedInteractorOutput {
    func error(code: Int) {
        DispatchQueue.main.async {[weak self] in
            self?.viewInput?.showErrorView(code: code)
        }
    }
}

// MARK: - FeedViewOutput Implementation

extension FeedPresenter: FeedViewOutput {
    func viewDestroyed() {
        
    }
}

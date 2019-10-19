//
//  FeedFeedAssembly.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

import UIKit

// MARK: - Module Build

class FeedAssembly {
    func buildModule() -> FeedPresenterInterface? {
        let view = FeedViewController()
        let interactor = FeedInteractor()
        let presenter = FeedPresenter()
        
        presenter.view = view
        presenter.interactor = interactor

        interactor.output = presenter
        view.output = presenter

        return presenter
    }
}

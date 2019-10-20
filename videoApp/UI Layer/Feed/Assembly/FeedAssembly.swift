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
    func buildModule() -> FeedPresentationModelInterface? {
        let view = FeedViewController()
        let presenter = FeedPresentationModel()
        
        presenter.view = view

        view.output = presenter

        return presenter
    }
}

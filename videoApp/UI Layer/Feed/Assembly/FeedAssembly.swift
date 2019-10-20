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
    func buildModule() -> FeedViewController {
        let view = FeedViewController()
        let presenter = FeedPresentationModel(view: view, service: ServiceProvider.instance.postService)
        view.output = presenter
        return view
    }
}

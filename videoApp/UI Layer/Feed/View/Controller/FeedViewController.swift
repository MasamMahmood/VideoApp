//
//  FeedFeedViewController.swift
//  video-app-ios
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 ov. All rights reserved.
//

import UIKit

//MARK: - Dependences & IBOutlets & IBActions & Life Cycle

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewOutput: FeedViewOutput?
}

//MARK: - FeedViewInput implementation

extension FeedViewController: FeedViewInput {    
    var currentController: UIViewController {
        return self
    }
    
    var rootNavigationController: UINavigationController? {
        return navigationController
    }

    var output: FeedViewOutput? {
        get {
            return viewOutput
        }
        set {
            viewOutput = newValue
        }
    }

}

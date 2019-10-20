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
    private var posts: [IPost] = []
    
    override func viewDidLoad() {
        let presenter = FeedPresentationModel(view: self, service: ServiceProvider.instance.postService)
        self.output = presenter
        setupTableView()
        viewOutput?.feedRequested(completion: { [weak self] posts in
            guard let self = self else { return }
            self.posts = posts
            self.tableView.reloadData()
        })
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.registerReusableCell(FeedBoxTableViewCell.self)
    }
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

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedBoxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(with: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

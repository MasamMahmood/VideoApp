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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)

        viewOutput?.feedRequested(completion: { [weak self] posts in
            guard let self = self else { return }
            self.posts = posts
            self.tableView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayeVideos()
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView, appEnteredFromBackground: true)
    }

    func pausePlayeVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.registerReusableCell(FeedContentTableViewCell.self)
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
        if let content = posts[indexPath.row] as? IContentPost {
            let cell: FeedContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: content, vc: self)
            return cell
        } else if let box = posts[indexPath.row] as? IBoxPost {
            
        } else {
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? ASAutoPlayVideoLayerContainer, videoCell.videoURL != nil {
            ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
        }
    }
    
}

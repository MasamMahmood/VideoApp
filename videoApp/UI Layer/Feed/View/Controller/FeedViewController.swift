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
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        let presenter = FeedPresentationModel(view: self, service: ServiceProvider.instance.postService)
        self.output = presenter
        setupTableView()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)

        viewOutput?.feedRequested()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayVideos()
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayVideosFor(tableView: tableView, appEnteredFromBackground: true)
    }

    func pausePlayVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayVideosFor(tableView: tableView)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView?.registerReusableCell(FeedContentTableViewCell.self)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
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
    
    func feedRecieved(posts: [IPost], indexPathToReload: [IndexPath]?) {
        self.posts = posts
        if let paths = indexPathToReload {
            let indexPathsToReload = visibleIndexPathsToReload(intersecting: paths)
            tableView.beginUpdates()
            tableView.insertRows(at: paths, with: .automatic)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
        }
    }

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
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
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewOutput?.feedRequested()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pausePlayVideos()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayVideos()
        }
    }
}

private extension FeedViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= (posts.count - 2)
  }

  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}

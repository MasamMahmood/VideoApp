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
    private var mute: Bool {
        return ASVideoPlayerController.sharedVideoPlayer.mute
    }
    private let router = Router()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayVideos()
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayVideosFor(tableView: tableView, appEnteredFromBackground: true)
    }

    private func setup() {
        let presenter = FeedPresentationModel(view: self,
                                              service: ServiceProvider.instance.postService)
        self.output = presenter
        setupTableView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)

        viewOutput?.feedRequested()
        ASVideoPlayerController.sharedVideoPlayer.sendVideoCounterAction = viewOutput?.postViewed(postId:)
    }
    
    private func pausePlayVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayVideosFor(tableView: tableView)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView?.registerReusableCell(FeedContentTableViewCell.self)
        tableView?.registerReusableCell(FeedBoxTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshPosts(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshPosts(_ sender: Any) {
        viewOutput?.refreshRequested()
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
            tableView.beginUpdates()
            tableView.insertRows(at: paths, with: .automatic)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func showShare(text: String) {
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view 
        self.present(activityViewController, animated: true, completion: nil)
    }

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let content = posts[indexPath.row] as? IContentPost {
            let cell: FeedContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.setup(with: content, mute: mute, needTopInset: true)
            return cell
        } else if let box = posts[indexPath.row] as? IBoxPost {
            let cell: FeedBoxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: box)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if posts[indexPath.row] is IBoxPost {
            tabBarController?.selectedIndex = 1
        }
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

extension FeedViewController: FeedContentCellDelegate {
   
    func likePressed(id: String) {
        viewOutput?.postLiked(postId:id)
    }
    
    func commentPressed(post: IContentPost) {
        router.openComments(vc: self, post: post)
    }
    
    func sharePressed(id: String) {
        viewOutput?.postShared(postId: id)
    }
    
    func mutePressed() {
        ASVideoPlayerController.sharedVideoPlayer.mute = !mute
    }
    
}

private extension FeedViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= (posts.count - 2)
  }
}

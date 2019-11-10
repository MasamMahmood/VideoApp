//
//  CommentsViewController.swift
//  videoApp
//
//  Created by Olga Vorona on 09/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//
import UIKit
import FloatingPanel

final class CommentsViewController: UIViewController, CommentsViewInput, FloatingPanelControllerDelegate {
    var post: IContentPost!

    private var output: CommentsViewOutput?
    private var fpc: FloatingPanelController!
    private var mute: Bool {
        return ASVideoPlayerController.sharedVideoPlayer.mute
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fpc.removePanelFromParent(animated: true)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setup() {
        let presenter = CommentsPresentationModel(view: self,
                                              service: ServiceProvider.instance.postService)
        self.output = presenter
        setupTableView()
        setupPanel()
    }
    
    private func setupPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self // Optional
        let contentVC = BottomSheetViewController()
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        fpc.addPanel(toParent: self)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.registerReusableCell(FeedContentTableViewCell.self)
    }

}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.setup(with: post, mute: mute, needTopInset: false)
        return cell
    }
    
}

extension CommentsViewController: FeedContentCellDelegate {
    func likePressed(id: String) {
        output?.postLiked(postId:id)
    }
    
    func commentPressed(post: IContentPost) {
    }
    
    func sharePressed(id: String) {
        output?.postShared(postId: id)
        let text = "Hey! You gotta see that! 😂🤣 https://lols.link/share?\(id)"
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func mutePressed() {
        ASVideoPlayerController.sharedVideoPlayer.mute = !mute
    }
}

//
//  FeedBoxTableViewCell.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

protocol FeedContentCellDelegate: NSObjectProtocol {
    func likePressed()
    func commentPressed()
    func sharePressed()
}

final class FeedContentTableViewCell: UITableViewCell, ICollectionCellFromNib, ASAutoPlayVideoLayerContainer {
   
    //MARK: - ASAutoPlayVideoLayerContainer
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
        
    var videoURL: String? {
        didSet {
            if let videoURL = videoURL {
                ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
            }
            videoLayer.isHidden = videoURL == nil
        }
    }
    
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(videoContainer.frame, from: videoContainer)
        guard let videoFrame = videoFrameInParentSuperView,
            let superViewFrame = superview?.frame else {
             return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
    
    //MARK: - ICollectionCellFromNib

    static var reuseIdentifier: String = "FeedContentTableViewCell"
    
    weak var delegate: FeedContentCellDelegate? = nil
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var actionsContainer: UIStackView!
    @IBOutlet weak var mockImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoHeightConstraint: NSLayoutConstraint!

    //MARK: - Cell

    override func prepareForReuse() {
        for subview in actionsContainer.arrangedSubviews {
            actionsContainer.removeArrangedSubview(subview)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = AVLayerVideoGravity.resize
        selectionStyle = .none
        mockImage.layer.addSublayer(videoLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoLayer.frame = CGRect(x: 0, y: 0, width: superview?.frame.width ?? 0, height: videoHeightConstraint.constant)
    }
    
    func setup(with post: IContentPost) {
        videoURL = post.postUrl
        titleLabel.text = post.title
        mockImage.sd_setImage(with: URL(string: post.thumbnailUrl ?? ""), completed: nil)
        videoHeightConstraint.constant = countHeight(width: post.width, height: post.height)
        layoutSubviews()
        setupActions(post: post)
    }
      
    @IBAction func soundButtonPressed(_ sender: Any) {
    
    }
      
    private func countHeight(width: Int, height: Int) -> CGFloat {
          let imageProportion = videoContainer.frame.width / CGFloat(width)
        return CGFloat(height) * imageProportion
    }
    
    private func setupActions(post: IContentPost) {
        let views: ActionView = ActionView.loadFromXib()
        views.setup(type: .views, text: "\(post.views)", action: nil)
        actionsContainer.addArrangedSubview(views)
        
        let likes: ActionView = ActionView.loadFromXib()
        likes.setup(type: .likes, text: "\(post.likes)", action: delegate?.likePressed)
        actionsContainer.addArrangedSubview(likes)
        
        let comments: ActionView = ActionView.loadFromXib()
        comments.setup(type: .comments, text: "\(post.commentsCount)", action: delegate?.commentPressed)
        actionsContainer.addArrangedSubview(comments)
        
        let shares: ActionView = ActionView.loadFromXib()
        shares.setup(type: .shares, text: "\(post.shares)", action: delegate?.sharePressed)
        actionsContainer.addArrangedSubview(shares)

    }
}

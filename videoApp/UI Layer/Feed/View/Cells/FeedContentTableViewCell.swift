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
    func likePressed(id: String)
    func commentPressed(id: String)
    func sharePressed(id: String)
    func mutePressed()
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
    
    var postId: String = ""
    
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(videoContainer.frame, from: videoContainer)
        guard let videoFrame = videoFrameInParentSuperView,
            let superViewFrame = superview?.frame else {
             return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
    
    func videoPlayStarted(mute: Bool) {
        self.mute = mute
        audioButton.setImage(UIImage(named: mute ? "mute" :"unmute"), for: .normal)
        audioButton.isHidden = false
    }
    
    func videoPlayStopped() {
        audioButton.isHidden = true
    }
    
    //MARK: - ICollectionCellFromNib

    static var reuseIdentifier: String = "FeedContentTableViewCell"
    
    private var mute: Bool = false
    weak var delegate: FeedContentCellDelegate? = nil
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var actionsContainer: UIStackView!
    @IBOutlet weak var mockImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var audioButton: UIButton!
    
    
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
    
    func setup(with post: IContentPost, mute: Bool) {
        postId = post.id
        videoURL = post.postUrl
        titleLabel.text = post.title
        mockImage.sd_setImage(with: URL(string: post.thumbnailUrl ?? ""), completed: nil)
        videoHeightConstraint.constant = countHeight(width: post.width, height: post.height)
        layoutSubviews()
        setupActions(post: post)
        self.mute = mute
        audioButton.setImage(UIImage(named: mute ? "mute" :"unmute"), for: .normal)
    }

    @IBAction func soundButtonPressed(_ sender: Any) {
        mute = !mute
        audioButton.setImage(UIImage(named: mute ? "mute" :"unmute"), for: .normal)
        delegate?.mutePressed()
    }
      
    private func countHeight(width: Int, height: Int) -> CGFloat {
        guard width != 0 else { return 100 }
        let imageProportion = videoContainer.frame.width / CGFloat(width)
        return (CGFloat(height) * imageProportion)
    }
    
    private func setupActions(post: IContentPost) {
        let views: ActionView = ActionView.loadFromXib()
        views.setup(type: .views, counter: post.views, action: nil)
        actionsContainer.addArrangedSubview(views)
        
        let likes: ActionView = ActionView.loadFromXib()
        likes.setup(type: .likes, counter: post.likes, action: {[weak self] in self?.delegate?.likePressed(id: post.id) })
        actionsContainer.addArrangedSubview(likes)
        
        let comments: ActionView = ActionView.loadFromXib()
        comments.setup(type: .comments, counter: post.commentsCount, action: {[weak self] in self?.delegate?.commentPressed(id: post.id) })
        actionsContainer.addArrangedSubview(comments)
        
        let shares: ActionView = ActionView.loadFromXib()
        shares.setup(type: .shares, counter: post.shares, action: {[weak self] in self?.delegate?.sharePressed(id: post.id) })
        actionsContainer.addArrangedSubview(shares)

    }
}

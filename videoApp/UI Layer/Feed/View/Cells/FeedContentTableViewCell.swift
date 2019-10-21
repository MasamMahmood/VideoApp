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

class FeedContentTableViewCell: UITableViewCell, ICollectionCellFromNib, ASAutoPlayVideoLayerContainer {
   
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
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(videoContainer.frame, from: shotImageView)
        guard let videoFrame = videoFrameInParentSuperView,
            let superViewFrame = superview?.frame else {
             return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
    
    static var reuseIdentifier: String = "FeedContentTableViewCell"
    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var actionsContainer: UIStackView!
    @IBOutlet weak var mockImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = AVLayerVideoGravity.resize
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupPlayer() {

    }
    
    func setup(with post: IContentPost, vc: UIViewController) {
        titleLabel.text = post.title
        mockImage.sd_setImage(with: URL(string: post.thumbnailUrl ?? ""), completed: nil)
        videoHeightConstraint.constant = countHeight(width: post.width, height: post.height)
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func countHeight(width: Int, height: Int) -> CGFloat {
        let imageProportion = videoContainer.frame.size.width / CGFloat(width)
        return CGFloat(height) * imageProportion
    }
}

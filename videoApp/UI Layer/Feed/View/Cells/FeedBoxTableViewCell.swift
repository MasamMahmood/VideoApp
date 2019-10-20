//
//  FeedBoxTableViewCell.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit
import Player

class FeedBoxTableViewCell: UITableViewCell, PlayerDelegate, PlayerPlaybackDelegate {
    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var actionsContainer: UIStackView!
    @IBOutlet weak var mockImage: UIImageView!
    let player = Player()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupPlayer() {
        self.player.playerDelegate = self
        self.player.playbackDelegate = self
        self.player.view.frame = self.videoContainer.bounds
//        self.addChild(self.player)
        self.videoContainer.addSubview(self.player.view)
//        self.player.didMove(toParent: self)
    }
    
    func setup(with: IContentPost) {
        player.url = URL(string: "https://media-cont.s3-us-west-1.amazonaws.com/encoded-web/2019/10/16/auto_1571198030786.mp4") 
    }
    
    func playerReady(_ player: Player) {
        
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        
    }
    
    func playerCurrentTimeDidChange(_ player: Player) {
        
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
}

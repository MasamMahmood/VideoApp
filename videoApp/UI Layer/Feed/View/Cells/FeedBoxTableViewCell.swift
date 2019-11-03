//
//  FeedContentTableViewCell.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit
import SDWebImage

class FeedBoxTableViewCell: UITableViewCell, ICollectionCellFromNib {
    static var reuseIdentifier: String = "FeedBoxTableViewCell"
    @IBOutlet weak var startImageView: SDAnimatedImageView!
    @IBOutlet weak var heightCOnstraint: NSLayoutConstraint!
    
    func setup(with post: IBoxPost) {
        if post.status == "opened" {
            startImageView.sd_setImage(with: URL(string: post.prizeUrl ?? ""), completed: nil)
        } else {
            startImageView.sd_setImage(with: URL(string: post.thumbnailUrl), completed: nil)
        }
        heightCOnstraint.constant = countHeight(width: post.width, height: post.height)
    }

    private func countHeight(width: Int, height: Int) -> CGFloat {
        guard width != 0 else { return 100 }
        let imageProportion = self.frame.width / CGFloat(width)
        return (CGFloat(height) * imageProportion)
    }
}

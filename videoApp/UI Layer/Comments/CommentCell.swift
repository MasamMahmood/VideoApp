//
//  CommentCell.swift
//  videoApp
//
//  Created by Olga Vorona on 10/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell, ICollectionCellFromNib {
    static var reuseIdentifier: String = "CommentCell"

    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with comment: IComment) {
        commentsLabel.text = comment.comment
        dateLabel.text = getTimeString(date: comment.createAt)
    }
    
    private func getTimeString(date: Date) -> String {
        let difference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
        var result = ""
        if let years = difference.year,
            years > 0 {
            result = "\(years) years"
        } else if let months = difference.month,
            months > 0 {
            result = "\(months) months"
        } else if let day = difference.day,
            day > 0 {
            result = "\(day) days"
        } else if let hours = difference.hour,
            hours > 0 {
            result = "\(hours) hours"
        } else if let minutes = difference.minute,
            minutes > 0 {
            result = "\(minutes) minutes"
        } else if let seconds = difference.second,
            seconds > 0 {
            result = "\(seconds) seconds"
        }
        
        return result + " ago"
    }
}

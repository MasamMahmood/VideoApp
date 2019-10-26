//
//  ActionView.swift
//  videoApp
//
//  Created by Olga Vorona on 26/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

enum ActionType {
    case comments
    case views
    case likes
    case shares
}

class ActionView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setup(type: ActionType, text: String) {
        label.text = text
    }
    
}

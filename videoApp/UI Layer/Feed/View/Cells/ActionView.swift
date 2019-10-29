//
//  ActionView.swift
//  videoApp
//
//  Created by Olga Vorona on 26/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

enum ActionType: String {
    case comments
    case views
    case likes
    case shares
}

class ActionView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    private var action: VoidClosure?
    private var type: ActionType?
    private var counter: Int = 0

    func setup(type: ActionType, counter: Int, action: VoidClosure?) {
        self.type = type
        self.counter = counter
        label.text = "\(counter)"
        image.image = UIImage(named: type.rawValue)
        self.action = action
    }
    
    @IBAction func actionSelected(_ sender: Any) {
        if type == .likes || type == .shares {
            counter = counter + 1
            label.text = "\(counter)"
        }
        action?()
    }
}
